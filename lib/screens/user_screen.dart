import 'package:flutter/material.dart';
import 'package:hoabactravel/screens/profile/change_password.dart';
import 'package:hoabactravel/screens/profile/my_account.dart';
import 'package:hoabactravel/screens/profile/profile_menu.dart';
import 'package:hoabactravel/screens/profile/profile_pic.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                            MyAccount(),
                      ),
                    ),
                  },
                ),
                ProfileMenu(
                  text: "Đánh giá",
                  icon: "assets/images/star-user.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Đổi mật khẩu",
                  icon: "assets/images/settings.2.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangePassword(),
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
                  press: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
