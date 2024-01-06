class DetailUpdate {
  final String id;
  final String service_name;
  final String url;
  final String type_of_day;
  final String number_of_adults;
  final String start_date;
  final String end_date;

  DetailUpdate({
    required this.id,
    required this.service_name,
    required this.url,
    required this.type_of_day,
    required this.number_of_adults,
    required this.start_date,
    required this.end_date
  });

  factory DetailUpdate.fromJson(Map<String, dynamic> json) {
    return DetailUpdate(
      id: json['id'].toString(),
      service_name: json['service_name'].toString(),
      url: json['url'].toString(),
      type_of_day: json['type_of_day'].toString(),
      number_of_adults: json['number_of_adults'].toString() ,
      start_date: json['start_date'].toString(),
      end_date: json['end_date'].toString(),
    );
  }
}

class UpdateBookModel {
  final int id;
  final String type_of_day;
  final double price_cost;
  final int number_of_adults;
  final DateTime start_date;
  final DateTime end_date;
  final double total_cost;

  UpdateBookModel({
    required this.id,
    required this.type_of_day,
    required this.price_cost,
    required this.number_of_adults,
    required this.start_date,
    required this.end_date,
    required this.total_cost,

  });

  toJson() => {
    "id":id,
    "type_of_day": type_of_day,
    "price_cost": price_cost,
    "number_of_adults": number_of_adults,
    "start_date": start_date.toIso8601String(),
    "end_date": end_date.toIso8601String(),
    "total_cost": total_cost,
  };

  factory UpdateBookModel.fromJson(Map<String, dynamic> json) {
    return UpdateBookModel(
      id: int.parse(json['id']),
      type_of_day: json['type_of_day'].toString(),
      price_cost: double.parse(json['price_cost']),
      number_of_adults: json['number_of_adults'] ,
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
      total_cost: json['total_cost'],
    );
  }
}
