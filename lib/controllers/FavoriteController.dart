import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/FavoriteModel.dart';
import 'package:hoabactravel/models/Item.dart';
import 'package:hoabactravel/models/ItemPopularModel.dart';
import 'package:http/http.dart' as http;

class FavoriteController {
  static Future<List<FavoriteModel>> getfavoriteModel(String? userId) async {
    final response = await http.get(Uri.parse(baseURL + "/apilistfavorite.php?id=$userId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      return data.map((e) => FavoriteModel.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu từ API');
    }
  }
}