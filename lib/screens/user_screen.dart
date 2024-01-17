import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hoabactravel/constants.dart';
import 'package:hoabactravel/models/UpdateUserModel.dart';
import 'package:hoabactravel/screens/list_rating_screen.dart';
import 'package:hoabactravel/screens/login_screen.dart';
import 'package:hoabactravel/screens/profile/change_password.dart';
import 'package:hoabactravel/screens/profile/my_account.dart';
import 'package:hoabactravel/screens/profile/profile_menu.dart';
import 'package:hoabactravel/screens/profile/profile_pic.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../utils/LoginProvider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  void logout(BuildContext context) async{
    final url = Uri.parse(baseURL + '/logout.php');
    final response = await post(url);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Đăng xuất thành công!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
      Navigator.push(context, MaterialPageRoute(builder: (cont) => LoginScreen()));
    } else {
      Fluttertoast.showToast(
        msg: "Đăng xuất thất bại!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? userId = context.watch<LoginProvider>().userId;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ProfilePic(),
                SizedBox(height: 20),
                ProfileMenu(
                  text: "Tài khoản của tôi",
                  icon: "assets/images/User.svg",
                  press: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyAccount(userId: userId.toString(),),
                      ),
                    ),
                  },
                ),
                ProfileMenu(
                  text: "Các dịch vụ đã đánh giá",
                  icon: "assets/images/star-user.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListRatingScreen(userId: userId.toString(),),
                      ),
                    );
                  },
                ),
                ProfileMenu(
                  text: "Đổi mật khẩu",
                  icon: "assets/images/settings.2.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangePassword(userId: userId.toString(),),
                      ),
                    );
                  },
                ),
                /*ProfileMenu(
                  text: "Đơn hàng",
                  icon: "assets/images/order.svg",
                  press: () {},
                ),*/
                ProfileMenu(
                  text: "Đăng xuất",
                  icon: "assets/images/log_out.svg",
                  press: () {
                    logout(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
