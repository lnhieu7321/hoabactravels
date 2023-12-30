import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/Item.dart';
import 'package:hoabactravel/models/ItemPopularModel.dart';
import 'package:http/http.dart' as http;

class ApiServicePopular {
  static Future<List<ServicePopular>> getServicesPopular() async {
    final response = await http.get(Uri.parse(baseURL + "/apiservicepopular.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      return data.map((e) => ServicePopular.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu từ API');
    }
  }
}