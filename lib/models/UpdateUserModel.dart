class UpdateUser {
  int id;
  String name;
  String email;
  String phone;
  String logo;
  String firstName;
  String lastName;
  String address;
  String ward;
  String district;
  String city;

  UpdateUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.logo,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.ward,
    required this.district,
    required this.city,
  });

  factory UpdateUser.fromJson(Map<String, dynamic> json) {
    return UpdateUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? "",
      logo: json['logo'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      address: json['address'] ?? "",
      ward: json['ward'] ?? "",
      district: json['district'] ?? "",
      city: json['city'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'logo': logo,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'ward': ward,
      'district': district,
      'city': city,
    };
  }
}