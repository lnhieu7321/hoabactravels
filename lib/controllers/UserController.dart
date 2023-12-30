import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as http;

class UserController {


  Future<void> updateUserData(UserModel userModel) async {
    final response = await http.post(
      Uri.parse('$baseURL/apiupdateuser.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userModel.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update user data');
    }
  }
}
