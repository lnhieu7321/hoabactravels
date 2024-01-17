import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/ListRating.dart';
import 'package:http/http.dart' as http;

import '../models/BookTicket.dart';


class ListRatingController {
  static Future<List<ListRating >> getListRating (String? userId) async {
    final response = await http.get(Uri.parse(baseURL + "/apilistrating.php?id=$userId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      return data.map((e) => ListRating.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu từ API');
    }
  }
}