import 'dart:convert';

import 'package:hoabactravel/models/UpdateUserModel.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/UserModel.dart';

class UserController {

  Future<UserModel> fetchProfile(String? userId) async {
    final headers = {'Content-Type': 'application/json'};
    final url = Uri.parse(baseURL + '/apiuser.php?id=$userId');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json.containsKey('error')) {
        throw Exception(json['error']);
      } else {
        return UserModel.fromJson(json);
      }
    } else if (response.statusCode == 400) {
      throw Exception('Invalid service ID');
    } else if (response.statusCode == 404) {
      throw Exception('Service not found');
    } else {
      throw Exception('Unexpected error');
    }
  }

  /*Future<UserModel? > fetchProfile(String? userId) async {
    try {
      final response = await http.get(
          Uri.parse(baseURL + '/apiuser.php?id=$userId'));

      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        return UserModel.fromJson(profileData);
      } else {
        throw Exception('Error fetching profile hieu: ${response.body}');
      }
    } catch (error) {
      print('Error fetching profile: $error');
      return null;
    }
  }*/

  Future<UpdateUser> updateInfor(UpdateUser updateUser) async {
    final url = Uri.parse('$baseURL/apiupdateuser.php');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updateUser.toJson()),
    );

    if (response.statusCode == 200) {
      final bookingJson = jsonDecode(response.body);
      return UpdateUser.fromJson(bookingJson);
    } else {
      print('Error creating booking: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("Update fail");
    }
  }

}