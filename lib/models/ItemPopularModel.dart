

class ServicePopular {
  final String id;
  final String url;
  final String serviceName;
  final String price;
  final String address;
  final String avgRate;

  ServicePopular({
    required this.id,
    required this.url,
    required this.serviceName,
    required this.price,
    required this.address,
    required this.avgRate,


  });

  factory ServicePopular.fromJson(Map<String, dynamic> json) {
    return ServicePopular(
      id: json['id'],
      url: json['url'],
      serviceName: json['service_name'],
      price: json['price'],
      address: json['address'],
      avgRate: json['avg_rate'],

    );

  }
}