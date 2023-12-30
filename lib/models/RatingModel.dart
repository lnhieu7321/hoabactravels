class Rating {
  final int rate;
  final String comment;
  final int customersId;
  final int bookingsId;
  final int servicesId;

  Rating({

    required this.rate,
    required this.comment,
    required this.customersId,
    required this.bookingsId,
    required this.servicesId,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      comment: json['comment'],
      customersId: json['customers_id'],
      bookingsId: json['bookings_id'],
      servicesId: json['services_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'comment': comment,
      'customers_id': customersId,
      'bookings_id': bookingsId,
      'services_id': servicesId,
    };
  }
}