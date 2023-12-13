
import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/DetailItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailServiceController {
  Future<DetailService> fetchDetailService(String? id) async {
    final headers = {'Content-Type': 'application/json'};
    final url = Uri.parse(baseURL + '/detailservice.php?id=$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json.containsKey('error')) {
        throw Exception(json['error']);
      } else {
        return DetailService.fromJson(json);
      }
    } else if (response.statusCode == 400) {
      throw Exception('Invalid service ID');
    } else if (response.statusCode == 404) {
      throw Exception('Service not found');
    } else {
      throw Exception('Unexpected error');
    }
  }
}

