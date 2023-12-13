import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
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

  Future<void> createBooking(BookingModel booking) async {
    try {
      // Update the API URL with your actual URL
      final response = await Dio().post(
        '$baseURL/apibooking.php',
        data: booking.toJson(),
      );
      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Booking created successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 400) {
        Get.snackbar('Error', 'Invalid input', snackPosition: SnackPosition.BOTTOM);
      } else if (response.statusCode == 404) {
        Get.snackbar('Error', 'Service not found', snackPosition: SnackPosition.BOTTOM);
      } else if (response.statusCode == 500) {
        Get.snackbar('Error', 'Failed to create booking', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Unexpected error', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


}
