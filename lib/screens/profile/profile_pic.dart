import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: const Column(
        children: [
          CircleAvatar(
            radius:40.0,
            backgroundImage: AssetImage("assets/images/icon_logo.png"),
          ),
          Text('Ngọc Hiếu' , style: TextStyle(fontSize: 20),),
          Text('lengochieu732001@gmail.com')
        ],
      ),
    );
  }
}
