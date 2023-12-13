import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Quản lý đặt chỗ của bạn",
              style: TextStyle(color: Color(0xFF475269)),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
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
                          Icon(CupertinoIcons.doc),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Chưa hoàn thành',
                            style: TextStyle(
                                color: Color(0xFF475269), fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              // Tên
                              Expanded(
                                child: Text("Làng mê", style: TextStyle(color: Color(0xFF475269)),),
                              ),
                              Expanded(
                                child: Text("15/12/2023", style: TextStyle(color: Color(0xFF475269)),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                          Icon(CupertinoIcons.doc_checkmark),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Đã hoàn thành',
                            style: TextStyle(
                                color: Color(0xFF475269), fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              // Tên
                              Expanded(
                                child: Text("Nam Yên CamPing" , style: TextStyle(color: Color(0xFF475269)),),
                              ),
                              Expanded(
                                child: Text("10/12/2023", style: TextStyle(color: Color(0xFF475269)),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
