import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;
class ChangePassword extends StatefulWidget {
  final String? userId;

  const ChangePassword({super.key, this.userId});
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {


  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newrefeshPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              // Mật kẩu cũ
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock_outline),
                          SizedBox(width: 5,),
                          Text(
                            'Mật khẩu cũ',
                            style: TextStyle(
                                color: Color(0xFF475269), fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          // Tên
                          Expanded(
                            child: TextFormField(
                              controller: _oldPasswordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                //labelText: "Tên",
                              ),
                              onChanged: (value) {},
                            ),

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //Mật khẩu mới
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock_open),
                          SizedBox(width: 5,),
                          Text(
                            'Mật khẩu mới',
                            style: TextStyle(
                                color: Color(0xFF475269), fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          // Tên
                          Expanded(
                            child: TextFormField(
                              controller: _newPasswordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onChanged: (value) {},
                            ),

                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Nhập lại mật khẩu
                      Row(
                        children: [
                          Icon(Icons.lock_open),
                          SizedBox(width: 5,),
                          Text(
                            'Nhập lại mật khẩu',
                            style: TextStyle(
                                color: Color(0xFF475269), fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          // Tên
                          Expanded(
                            child: TextFormField(
                              controller: _newrefeshPasswordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                //labelText: "Tên",
                              ),
                              onChanged: (value) {},
                            ),

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //lưu
                    GestureDetector(
                      onTap: () {
                        http.post(Uri.parse(baseURL + '/apichangepass.php'),
                          body: {
                            'id': widget.userId,
                            'oldPassword': _oldPasswordController.text,
                            'newPassword': _newPasswordController.text,
                          },
                        ).then((response) {
                          // Xử lý kết quả
                          if (response.statusCode == 200) {
                            // Mật khẩu được đổi thành công
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Mật khẩu được đổi thành công'),
                              ),
                            );
                            Navigator.of(context).pop();
                          } else {
                            // Có lỗi xảy ra
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response.body),
                              ),
                            );
                          }
                        });

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFF028512),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Lưu",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 3),
                            Icon(
                              CupertinoIcons.doc_checkmark_fill,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFFA5A9A5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Trở lại",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 3),
                            Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Nút hủy

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
