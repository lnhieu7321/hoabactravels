import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/BookingModel.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController{


  Future<BookingService> fetchServicebooking(String? serviceId) async {
    final response = await http.get(Uri.parse(baseURL + '/apibooking.php?id=$serviceId'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json.containsKey('error')) {
        throw Exception(json['error']);
      } else {
        return BookingService.fromJson(json);
      }
    } else if (response.statusCode == 400) {
      throw Exception('Invalid service ID');
    } else if (response.statusCode == 404) {
      throw Exception('Service not found');
    } else {
      throw Exception('Unexpected error');
    }
  }

  Future<BookingModel> createBooking(BookingModel bookingModel) async {
    final url = Uri.parse(baseURL + '/apibook.php');
    final response = await http.post(
      url,
      headers: {"Content-Type" : "application/json; charset=UTF-8",},
      body: jsonEncode(bookingModel.toJson()),
    );
    if (response.statusCode == 201) {
      final bookingJson = jsonDecode(response.body);
      return BookingModel.fromJson(bookingJson);
    } else {
      print(response.headers);
      print('Error creating booking: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Booking creation failed');
    }
  }






}
