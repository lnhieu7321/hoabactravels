
import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import '../models/SearchModel.dart';
import 'package:hoabactravel/models/Item.dart';
import 'package:http/http.dart' as http;

class SearchServiceController {
  static Future<List<SearchModel>> getSearch(String query) async {
    final response = await http.get(Uri.parse(baseURL + "/apisearch.php?query=$query"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => SearchModel.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu từ API');
    }
  }
}
