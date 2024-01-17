

class ListRating {

  final String service_name;
  final String url;
  final int rate;
  final String start_date;
  final String comment;

  ListRating({

    required this.service_name,
    required this.url,
    required this.rate,
    required this.start_date,
    required this.comment,


  });

  factory ListRating.fromJson(Map<String, dynamic> json) {
    return ListRating(
      service_name: json['service_name'],
      url: json['url'],
      rate: int.parse(json['rate']),
      start_date: json['start_date'],
      comment: json['comment'],

    );

  }
}