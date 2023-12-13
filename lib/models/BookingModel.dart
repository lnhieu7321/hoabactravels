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
  final String typeOfDay;
  final int numberOfAdults;
  final String startDate;
  final String endDate;
  final double totalCost;
  final int servicesId;

  const BookingModel({
    required this.typeOfDay,
    required this.numberOfAdults,
    required this.startDate,
    required this.endDate,
    required this.totalCost,
    required this.servicesId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    typeOfDay: json['type_of_day'].toString(),
    numberOfAdults: json['number_of_adults'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    totalCost: json['total_cost'],
    servicesId: json['services_id'],
  );

  Map<String, dynamic> toJson() => {
    "type_of_day": typeOfDay,
    "number_of_adults": numberOfAdults,
    "start_date": startDate,
    "end_date": endDate,
    "total_cost": totalCost,
    "services_id": servicesId,
  };
}