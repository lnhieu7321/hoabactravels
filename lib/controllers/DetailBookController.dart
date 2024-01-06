
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icon.dart';
import 'dart:convert';

import '../models/DetailBook.dart';

class DetailBookController {
  Future<DetailBook> fetchDetailBook(String? id, String? userId) async {
    final headers = {'Content-Type': 'application/json'};
    final url = Uri.parse(baseURL + '/apiticketdetail.php?id=$id&userId=$userId');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json.containsKey('error')) {
        throw Exception(json['error']);
      } else {
        return DetailBook.fromJson(json);
      }
    } else if (response.statusCode == 400) {
      throw Exception('Invalid service ID');
    } else if (response.statusCode == 404) {
      throw Exception('Service not found');
    } else {
      throw Exception('Unexpected error');
    }
  }

  Future<void> cancelBooking(String? id) async {
    final headers = {'Content-Type': 'application/json'};
    final url = Uri.parse(baseURL + '/cancelbook.php?id=$id');
    final response = await http.put(url, headers: headers);

    if (response.statusCode == 204) {

      //Get.snackbar('Đã hủy dịch vụ thành công', 'Đã cập nhật trạng thái booking');
      print("Đã hủy dịch vụ thành công");
    } else if (response.statusCode == 400) {
      // Handle the specific error condition
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json['error'] == 'Không thể hủy dịch vụ') {
        Get.snackbar('Lỗi', 'Không thể hủy dịch vụ');
      } else {
        Get.snackbar('Lỗi không xác định', 'Vui lòng thử lại sau');
      }
    } else if (response.statusCode == 500) {
      // Cancellation failed
      Get.snackbar('Có lỗi xảy ra khi hủy dịch vụ', 'Vui lòng thử lại sau');
    } else {
      // Unexpected error
      Get.snackbar('Lỗi không xác định', 'Vui lòng liên hệ hỗ trợ');
    }
  }
}

