import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;

import '../models/BookTicket.dart';
import '../utils/LoginProvider.dart';
import 'package:provider/provider.dart';

class ApiBookTicket {
  static Future<List<BookTicket >> getBookTicket (String? userId) async {
    final response = await http.get(Uri.parse(baseURL + "/apibookedtickets.php?id=$userId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      return data.map((e) => BookTicket.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu từ API');
    }
  }
}