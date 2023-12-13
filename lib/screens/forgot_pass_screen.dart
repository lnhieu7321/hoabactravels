import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF2F5FA)),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                //logo
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 5),
                  child: Image.asset(
                    "assets/images/nentrang.png",
                    height: 80,
                  ),
                ),
                Text(
                  "Lấy lại mật khẩu của bạn ",
                  style: TextStyle(fontSize: 15,
                      color: Color(0xFF475269)),
                ),
                SizedBox(height: 50,),
                //input email
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF475269).withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 27,
                        color: Color(0xFF000000),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nhập Email",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                //button đăng nhâp
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "loginScreen");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF93D334),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF93D334).withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      "Gửi",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),

                // chuyển sang đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Bạn đã có mật khẩu? ",
                      style: TextStyle(
                        color: Color(0xFF464545).withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "loginScreen");
                      },
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
