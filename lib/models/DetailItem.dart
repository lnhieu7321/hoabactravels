class DetailService {
  final String id;
  final String serviceName;
  final String description;
  final String price;
  final String address;
  final String ward;
  final String district;
  final String city;
  final String url;
  final double avgRate;
  final String businessName;

  DetailService({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.price,
    required this.address,
    required this.ward,
    required this.district,
    required this.city,
    required this.url,
    required this.avgRate,
    required this.businessName,
  });

  factory DetailService.fromJson(Map<String, dynamic> json) {
    return DetailService(
      id: json['id'].toString(),
      serviceName: json['service_name'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      ward: json['ward'],
      district: json['district'],
      city: json['city'],
      url: json['url'],
      avgRate: double.parse(json['avg_rate'] ?? '0'),
      businessName: json['business_name'],
    );
  }
}
