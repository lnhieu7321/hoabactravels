

class Service {
  final String id;
  final String url;
  final String serviceName;
  final String price;
  final String address;

  Service({
    required this.id,
    required this.url,
    required this.serviceName,
    required this.price,
    required this.address,


  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      url: json['url'],
      serviceName: json['service_name'],
      price: json['price'],
      address: json['address'],

    );

  }
}