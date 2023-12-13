import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
                  height: 10,
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
                  "Hãy tạo một tài khoản, nó miễn phí",
                  style: TextStyle(fontSize: 15, color: Color(0xFF475269)),
                ),
                SizedBox(
                  height: 40,
                ),
                //input user name
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
                        Icons.person,
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
                            hintText: "Nhập Tên người dùng",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
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
                  height: 25,
                ),
                //input số điện thoại
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
                        Icons.phone,
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
                            hintText: "Nhập Số điện thoại",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                //input mật khẩu
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
                        Icons.lock,
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
                            hintText: "Nhập Mật khẩu",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //button quên mật khẩu
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Quên mật khẩu",
                      style: TextStyle(
                        color: Color(0xFF475269),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //button đăng nhâp
                InkWell(
                  onTap: () {},
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
                      "Đăng nhâp",
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
                  height: 15,
                ),

                // ------hoặc---------
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black12,
                                Colors.black54,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          "Hoặc",
                          style: TextStyle(
                              color: Color(0xFF2c2b2b),
                              fontSize: 16.0,
                              fontFamily: "WorkSansMedium"),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black54,
                                Colors.black12,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                    ],
                  ),
                ),

                //google, facebook
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 50.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/google.png",
                              width: 60,
                              height: 60,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/facebook.png",
                              width: 40,
                              height: 40,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                // chuyển sang đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Bạn đã có tài khoản? ",
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
