import 'package:designpattern/design_pattern/structural/adapter.dart';
import 'package:flutter/material.dart';

class AdapterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adapter'),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AdapterWidget(
                adapter: JsonContactsAdapter(),
                headerText: 'Contacts from JSON API:',
              ),
              const SizedBox(height: 10),
              AdapterWidget(
                adapter: XmlContactsAdapter(),
                headerText: 'Contacts from XML API:',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdapterWidget extends StatefulWidget {
  final ContactsAdapter adapter;
  final String headerText;

  AdapterWidget({
    @required this.adapter,
    @required this.headerText,
  });

  @override
  State<StatefulWidget> createState() {
    return _AdapterWidget();
  }
}

class _AdapterWidget extends State<AdapterWidget> {
  final List<Contact> contacts = List<Contact>();

  void _getContacts() {
    setState(() {
      contacts.addAll(widget.adapter.contacts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.headerText),
        const SizedBox(height: 10),
        Stack(
          children: <Widget>[
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: contacts.length > 0 ? 1.0 : 0.0,
              child: Column(
                children: contacts
                    .map((contact) => Card(
                          child: ListTile(
                            title: Text(contact.fullName),
                            subtitle: Text(contact.email),
                            trailing: Icon(
                              Icons.star,
                              color: contact.isFavorite
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: contacts.length == 0 ? 1.0 : 0.0,
              child: FlatButton(
                child: Text('Get contacts'),
                onPressed: _getContacts,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
