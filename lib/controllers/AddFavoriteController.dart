
import 'dart:convert';

import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/AddFavoriteModel.dart';
import 'package:http/http.dart' as http;


class FavoriteServiceController {
  Future<FavoriteService> addToFavorite(FavoriteService favoriteService) async {
    // Gọi API để tạo rating
    final response = await http.post(
        Uri.parse(baseURL + '/apiaddfavorite.php')
        ,headers: {"Content-Type" : "application/json; charset=UTF-8",}
        , body: jsonEncode(favoriteService));

    if (response.statusCode == 201) {
      return FavoriteService.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Lỗi' );
    }
  }
}