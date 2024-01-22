import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/ProfileHomeModel.dart';

class ProfileController {
  Future<ProfileHome?> fetchProfile() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/apiprofilehome.php'));

      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        return ProfileHome.fromJson(profileData);
      } else {
        throw Exception('Error fetching profile: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching profile: $error');
      return null;
    }
  }
}
