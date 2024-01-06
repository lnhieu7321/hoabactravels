
import 'package:flutter/cupertino.dart';
import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../models/DetailUpdate.dart';

class DetailUpdateController extends ChangeNotifier {
  
  Future<DetailUpdate> fetchDetailUpdate(String? id) async {
    final headers = {'Content-Type': 'application/json'};
    final url = Uri.parse(baseURL + '/apiupdatedetailbook.php?id=$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json.containsKey('error')) {
        throw Exception(json['error']);
      } else {
        return DetailUpdate.fromJson(json);
      }
    } else if (response.statusCode == 400) {
      throw Exception('Invalid service ID');
    } else if (response.statusCode == 404) {
      throw Exception('Service not found');
    } else {
      throw Exception('Unexpected error');
    }
  }

  Future<UpdateBookModel> updateBooking(UpdateBookModel updateBookModel) async {
    final url = Uri.parse('$baseURL/apiupdatebook.php');
    final response = await http.put(
      url,
      body: jsonEncode(updateBookModel.toJson()),
    );
    if (response.statusCode == 200) {
      final bookingJson = jsonDecode(response.body);
      return UpdateBookModel.fromJson(bookingJson);
    } else {
      //print('Error creating booking: ${response.statusCode}');
      //print('Response body: ${response.body}');
      throw Exception("Update fail");
    }
  }



}

