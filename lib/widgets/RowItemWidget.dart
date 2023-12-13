import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 1; i < 5; i++)
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 130,
              decoration: BoxDecoration(
                color: Color(0xFFF5F9FD),
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      /*Container(
                      //margin: EdgeInsets.only(top: 20, right: 70),
                      height: 120,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Color(0xFF475269),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),*/
                      Image.asset(
                        "assets/images/webInterFace.png",
                        height: 90,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          "Nam Yên Camping",
                          style: TextStyle(
                            color: Color(0xFF475269),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nam Yên, Hòa Bắc",
                          style: TextStyle(
                            color: Color(0xFF475269).withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("4.9"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\$50",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF93D334),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
