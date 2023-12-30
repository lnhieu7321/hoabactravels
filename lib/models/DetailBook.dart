class DetailBook {
  final String id;
  final String service_name;
  final String url;
  final String total_cost;
  final String type_of_day;
  final String number_of_adults;
  final String start_date;
  final String end_date;
  final String status_book;
  final String serviceId;
  final String address;
  final String ward;
  final String district;
  final String city;
  final String customerId;

  DetailBook({
    required this.id,
    required this.service_name,
    required this.url,
    required this.total_cost,
    required this.type_of_day,
    required this.number_of_adults,
    required this.start_date,
    required this.end_date,
    required this.status_book,
    required this.serviceId,
    required this.address,
    required this.ward,
    required this.district,
    required this.city,
    required this.customerId,
  });

  factory DetailBook.fromJson(Map<String, dynamic> json) {
    return DetailBook(
      id: json['id'].toString(),
      service_name: json['service_name'].toString(),
      url: json['url'].toString(),
      total_cost: json['total_cost'].toString(),
      type_of_day: json['type_of_day'].toString(),
      number_of_adults: json['number_of_adults'].toString(),
      start_date: json['start_date'].toString(),
      end_date: json['end_date'].toString(),
      status_book: json['status_book'].toString(),
      serviceId: json['serviceId'].toString(),
      address: json['address'].toString(),
      ward: json['ward'].toString(),
      district: json['district'].toString(),
      city: json['city'].toString(),
      customerId: json['customerId'].toString(),
    );
  }
}
