

class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String status = "Sync yet";

  Profile({
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
  });

  factory Profile.toJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['profileUrl'],
    );
  }
}