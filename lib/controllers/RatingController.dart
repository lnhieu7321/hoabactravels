import 'dart:convert';

import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;

import '../models/RatingModel.dart';

class RatingController {
  Future<Rating> createRating(Rating rating) async {
    // Gọi API để tạo rating
    final response = await http.post(
        Uri.parse(baseURL + '/rating.php')
        ,headers: {"Content-Type" : "application/json; charset=UTF-8",}
        , body: jsonEncode(rating));

    if (response.statusCode == 201) {
      return Rating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Lỗi' );
    }
  }
}