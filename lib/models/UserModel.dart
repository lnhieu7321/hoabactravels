

class UserModel {
  final int id;
  late final String name;
  late final String email;
  final String logo;
  late final String phone;
  late final String first_name;
  late final String last_name;
  late final String address;
  late final String ward;
  late final String district;
  late final String city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.logo,
    required this.phone,
    required this.first_name,
    required this.last_name,
    required this.address,
    required this.ward,
    required this.district,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      logo: json['logo'] as String,
      phone: json['phone'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
      address: json['address'].toString(),
      ward: json['ward'].toString(),
      district: ['district'].toString(),
      city: json['city'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'logo': logo,
      'first_name': first_name,
      'last_name': last_name,
      'address': address,
      'ward': ward,
      'district': district,
      'city': city,
    };
  }
}