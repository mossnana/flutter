import 'dart:convert';
import 'package:xml/xml.dart' as xml;

// Internal Model
class Contact {
  final String fullName;
  final String email;
  final bool isFavorite;

  const Contact({
    this.fullName,
    this.email,
    this.isFavorite,
  });
}

// Json Fake Data
class JsonFakerApi {
  final String _response = '''
  {
    "contacts": [
      {
        "fullName": "John Doe (JSON)",
        "email": "johndoe@json.com",
        "isFavorite": true
      },
      {
        "fullName": "Emma Doe (JSON)",
        "email": "emmadoe@json.com",
        "isFavorite": false
      },
      {
        "fullName": "Michael Roe (JSON)",
        "email": "michaelroe@json.com",
        "isFavorite": false
      }
    ]
  }
  ''';

  String getResponse() {
    return _response;
  }
}
// XML Fake Data
class XmlFakerApi {
  final String _response = '''
    <?xml version="1.0"?>
    <contacts>
      <contact>
        <fullname>John Doe (XML)</fullname>
        <email>johndoe@xml.com</email>
        <isFavorite>false</isFavorite>
      </contact>
      <contact>
        <fullname>Emma Doe (XML)</fullname>
        <email>emmadoe@xml.com</email>
        <isFavorite>true</isFavorite>
      </contact>
      <contact>
        <fullname>Michael Roe (XML)</fullname>
        <email>michaelroe@xml.com</email>
        <isFavorite>true</isFavorite>
      </contact>
    </contacts>
  ''';

  String getResponse() {
    return _response;
  }
}

// Adapter Interface
abstract class ContactsAdapter {
  List<Contact> contacts();
}
// Json Adapter
class JsonContactsAdapter implements ContactsAdapter {
  final JsonFakerApi _api = JsonFakerApi();

  @override
  List<Contact> contacts() {
    var _apiResponse = _api._response;
    var contactsList = _fromJson(_apiResponse);
    return contactsList;
  }

  List<Contact> _fromJson(String response) {
    var contactsMap = json.decode(response) as Map<String, dynamic>;
    var contactsJsonList = contactsMap['contacts'] as List;
    var contactsList = contactsJsonList
        .map((json) => Contact(
              fullName: json['fullName'],
              email: json['email'],
              isFavorite: json['isFavorite'],
            ))
        .toList();
    return contactsList;
  }
}
// XML Adapter
class XmlContactsAdapter implements ContactsAdapter {
  final XmlFakerApi _api = XmlFakerApi();

  @override
  List<Contact> contacts() {
    var _apiResponse = _api._response;
    var contactsList = _fromXml(_apiResponse);
    return contactsList;
  }

  List<Contact> _fromXml(String response) {
    var xmlDocument = xml.parse(response);
    var contactsList = List<Contact>();
    for (var xmlElement in xmlDocument.findAllElements('contact')) {
      var fullName = xmlElement.findElements('fullname').single.text;
      var email = xmlElement.findElements('email').single.text;
      var isFavoriteString = xmlElement.findElements('isFavorite').single.text;
      var isFavoriteBool = isFavoriteString.toLowerCase() == 'true';
      contactsList.add(Contact(
        fullName: fullName,
        email: email,
        isFavorite: isFavoriteBool,
      ));
    }
    return contactsList;
  }
}