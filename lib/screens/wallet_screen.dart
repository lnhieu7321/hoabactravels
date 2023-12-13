import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Quản lý ví của bạn",
              style: TextStyle(color: Color(0xFF475269)),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: 180,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {  },
                    child: Row(

                      children: [
                        Icon(CupertinoIcons.add, size: 25, color: Color(0xFF000000),),
                        SizedBox(width: 10,),
                        Text("Thêm ví", style: TextStyle(fontSize: 20, color: Color(0xFF000000)),),
                      ],
                    ),
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
                          Icon(Icons.wallet),
                          SizedBox(width: 5,),
                          Text(
                            'Tất cả ví của bạn',
                            style: TextStyle(
                                color: Color(0xFF475269), fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Row(
                        children: [
                          // Tên
                          Expanded(
                            child: Text("Momo"),
                          ),
                          Expanded(
                            child: Text("0785406231"),
                          ),
                        ],
                      ),),

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
