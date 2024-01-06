class SearchModel {
  String id;
  String serviceName;
  String price;
  String address;
  String url;

  SearchModel({
    required this.id,
    required this.serviceName,
    required this.price,
    required this.address,
    required this.url,
  });

  // Factory constructor to create Service objects from JSON
  factory SearchModel.fromJson(Map<String, dynamic> json){
    return SearchModel(
      id: json['id'],
      serviceName: json['service_name'],
      price: json['price'],
      address: json['address'],
      url: json['url'],
    );
  }
}
