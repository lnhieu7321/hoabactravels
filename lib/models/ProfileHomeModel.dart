

class ProfileHome {
  final int id;
  final String name;
  final String email;
  final String logo;

  ProfileHome({
    required this.id,
    required this.name,
    required this.email,
    required this.logo,
  });

  factory ProfileHome.fromJson(Map<String, dynamic> json) {
    return ProfileHome(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      logo: json['logo'] as String,
    );
  }
}