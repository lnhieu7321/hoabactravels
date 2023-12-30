import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/UserController.dart';
import 'package:hoabactravel/models/UserModel.dart';

import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../utils/LoginProvider.dart';

class MyAccount extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late final UserController _userController;


  Future<UserModel? > fetchProfile() async {
    String? userId = context.watch<LoginProvider>().userId;
    try {
      final response = await http.get(
          Uri.parse(baseURL + '/apiuser.php?id=$userId'));

      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        return UserModel.fromJson(profileData);
      } else {
        throw Exception('Error fetching profile hieu: ${response.body}');
      }
    } catch (error) {
      print('Error fetching profile: $error');
      return null;
    }
  }

  Future<void> updateUserData(UserModel userModel) async {
    final response = await http.post(
      Uri.parse('$baseURL/apiupdateuser.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userModel.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update user data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
      ),
      body: SafeArea(
        child: FutureBuilder<UserModel?>(
          future: fetchProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final profile = snapshot.data!;
              return  SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior: Clip.none,
                              children: [
                                if (profile.logo != null)
                                CircleAvatar(
                                    backgroundImage: NetworkImage(profile.logo!)),
                                Positioned(
                                  right: -16,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 46,
                                    width: 46,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: const BorderSide(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {

                                      },
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Color(0xFF93D334),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Tên người dùng
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
                                Icon(Icons.person),
                                SizedBox(width: 5,),
                                Text(
                                  'Tên người dùng',
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

                                    initialValue: profile.name!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {
                                      profile.name = value;
                                    },
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
                    //Email sdt
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
                                Icon(Icons.email),
                                SizedBox(width: 5,),
                                Text(
                                  'Email',
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

                                    initialValue: profile.email!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.email = value;},
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //số điện thoại
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 5,),
                                Text(
                                  'Số điện thoại',
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

                                    initialValue: profile.phone!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.phone = value;},
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
                    // Tên Và họ
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
                                Icon(Icons.perm_identity),
                                SizedBox(width: 5,),
                                Text(
                                  'Tên',
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

                                    initialValue: profile.first_name!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.first_name = value;},
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //họ và tên đệm
                            Row(
                              children: [
                                Icon(Icons.perm_identity),
                                SizedBox(width: 5,),
                                Text(
                                  'Họ và tên đệm',
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

                                    initialValue: profile.last_name!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.last_name = value;},
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
                    //Nơi ở
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
                            //------------------------------------------Địa chỉ
                            Row(
                              children: [
                                Icon(CupertinoIcons.location),
                                SizedBox(width: 5,),
                                Text(
                                  'Địa chỉ',
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

                                    initialValue: profile.address!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.address = value;},
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //------------------------------------------Xã

                            Row(
                              children: [
                                Icon(Icons.edit_location_alt_sharp),
                                SizedBox(width: 5,),
                                Text(
                                  'Phường(xã)',
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

                                   initialValue: profile.ward!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.ward = value;},
                                  ),

                                ),
                              ],
                            ),
                            //------------------------------------------quận

                            Row(
                              children: [
                                Icon(Icons.my_location_outlined),
                                SizedBox(width: 5,),
                                Text(
                                  'Quận(huyện)',
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

                                    initialValue: profile.district!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.district = value;},
                                  ),

                                ),
                              ],
                            ),
                            //------------------------------------------thành phố

                            Row(
                              children: [
                                Icon(Icons.location_city_outlined),
                                SizedBox(width: 5,),
                                Text(
                                  'Tỉnh(Thành Phố)',
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

                                    initialValue: profile.city!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      //labelText: "Tên",
                                    ),
                                    onChanged: (value) {profile.city = value;},
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
                              // Navigate to the booking page

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
                              // Navigate to the booking page
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

                    SizedBox(height: 15,),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

      ),
    );
  }
}
