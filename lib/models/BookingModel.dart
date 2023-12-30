class BookingService {
  final String id;
  final String serviceName;
  final String url;



  BookingService({
    required this.id,
    required this.serviceName,
    required this.url,


  });

  factory BookingService.fromJson(Map<String, dynamic> json) {
    return BookingService(
      id: json['id'].toString(),
      serviceName: json['service_name'] as String,
      url: json['url'] as String,



    );
  }
}


class BookingModel {
  String type_of_day;
  int number_of_adults;
  DateTime start_date;
  DateTime end_date;
  double total_cost;
  int customers_id;
  int services_id;
  String status_book;

  BookingModel({
    required this.type_of_day,
    required this.number_of_adults,
    required this.start_date,
    required this.end_date,
    required this.total_cost,
    required this.customers_id,
    required this.services_id,
    required this.status_book,
  });



  toJson() => {
    "type_of_day": type_of_day,
    "number_of_adults": number_of_adults,
    "start_date": start_date.toIso8601String(),
    "end_date": end_date.toIso8601String(),
    "total_cost": total_cost,
    "customers_id": customers_id,
    "services_id": services_id,
    "status_book": status_book,
  };

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      type_of_day: json['type_of_day'],
      number_of_adults: json['number_of_adults'],
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
      total_cost: json['total_cost'].toDouble(),
      customers_id: json['customers_id'],
      services_id: json['services_id'],
      status_book: json['status_book'],
    );
  }


}