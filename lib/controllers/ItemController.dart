
import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/Item.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Service>> getServices() async {
    final response = await http.get(Uri.parse(baseURL + "/apiservicehome.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      return data.map((e) => Service.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu từ API');
    }
  }
}