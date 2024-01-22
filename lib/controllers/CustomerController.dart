import 'dart:convert';
import 'package:hoabactravel/models/User.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;

class CustomerController {
  static Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuth = await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    return userCredential.user;
  }

  static Future<String?> saveDataToDatabase(User user) async {
    try {
      final url = Uri.parse(baseURL + '/apisaveggdata.php'); // Thay thế bằng URL API của bạn
      final response = await http.post(
          url, body: json.encode({
        'email': user.email,
        'name': user.displayName,
        'photoUrl': user.photoURL,
      }));

      if (response.statusCode == 200) {
        //print('Lưu dữ liệu thành công vào MySQL');
          var data = json.decode(response.body);
          String usersId = data["id"];
          return usersId;
      } else {
        print('Lưu dữ liệu thất bại: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Lỗi khi lưu dữ liệu: $error');
    }
  }


}
