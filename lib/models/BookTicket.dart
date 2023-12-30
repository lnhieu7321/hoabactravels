

class BookTicket {
  final String id;
  final String service_name;
  final String total_cost;
  final String type_of_day;
  final String start_date;
  final String status_book;

  BookTicket({
    required this.id,
    required this.service_name,
    required this.total_cost,
    required this.type_of_day,
    required this.start_date,
    required this.status_book,


  });

  factory BookTicket.fromJson(Map<String, dynamic> json) {
    return BookTicket(
      id: json['id'],
      service_name: json['service_name'],
      total_cost: json['total_cost'],
      type_of_day: json['type_of_day'],
      start_date: json['start_date'],
      status_book: json['status_book'],

    );

  }
}