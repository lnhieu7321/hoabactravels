import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/UserController.dart';
import 'package:hoabactravel/models/UserModel.dart';

import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../models/UpdateUserModel.dart';
import '../../utils/LoginProvider.dart';

class MyAccount extends StatefulWidget {
  final String? userId;

  const MyAccount({super.key, this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _userController = UserController();
  late Future<UserModel> _futureUserModel;
  XFile? _image;
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  late String nameController;
  late String emailController;
  late String phoneController;
  late String firstNameController;
  late String lastNameController;
  late String addressController;
  late String wardController;
  late String districtController;
  late String cityController;
  late String logoController;
  late String imageURL;
  late Cloudinary cloudinary;

  @override
  void initState() {
    super.initState();
    //cloudinary = CloudinaryObject.fromCloudName(cloudName: 'duftginkc') as Cloudinary;
    _futureUserModel = UserController().fetchProfile(widget.userId.toString());
    UserController().fetchProfile(widget.userId.toString()).then((data) {
      setState(() {
        nameController = data!.name;
        emailController = data!.email;
        phoneController = data!.phone;
        firstNameController = data!.first_name;
        lastNameController = data!.last_name;
        addressController = data!.address;
        wardController = data!.ward;
        districtController = data!.district;
        cityController = data!.city;
        logoController = data!.logo;
      });
    });
  }

  Future<void> _updateUserCustomer() async {
    if (_imageFile != null){
      final url = Uri.parse('https://api.cloudinary.com/v1_1/duftginkc/upload');
      final request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = 'dbp6hpi5';
      request.files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        setState(() {
          final url = jsonMap['url'];
          imageURL = url;
        });
      }
    }

    if (_formKey.currentState!.validate()) {
      final updateUser = UpdateUser(
        id: int.parse(widget.userId.toString()),
        name: nameController,
        email: emailController,
        phone: phoneController,
        logo: _imageFile != null ? imageURL.toString() : logoController,
        firstName: firstNameController,
        lastName: lastNameController,
        address: addressController,
        ward: wardController,
        district: districtController,
        city: cityController,
      );

      await _userController.updateInfor(updateUser).catchError((error) {
        final updateUser = UpdateUser(
          id: int.parse(widget.userId.toString()),
          name: nameController,
          email: emailController,
          phone: phoneController,
          logo: _imageFile != null ? imageURL.toString() : logoController,
          firstName: firstNameController,
          lastName: lastNameController,
          address: addressController,
          ward: wardController,
          district: districtController,
          city: cityController,
        );
        return updateUser;
      });

      setState(() {
        Fluttertoast.showToast(
            msg: "Cập nhật thông tin thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    setState(() {
      if (image != null) _imageFile = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
      ),
      body: SafeArea(
        child: FutureBuilder<UserModel>(
          future: _futureUserModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final profile = snapshot.data!;
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                                        backgroundImage:
                                            NetworkImage(profile.logo!)),
                                  if (_imageFile != null)
                                    CircleAvatar(
                                        backgroundImage:
                                            FileImage(_imageFile!)),
                                  Positioned(
                                    right: -16,
                                    bottom: 0,
                                    child: SizedBox(
                                      height: 46,
                                      width: 46,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xFFF5F6F9),
                                        ),
                                        onPressed: () =>
                                            _pickImage(ImageSource.gallery),
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
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: nameController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        nameController = value;
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
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: emailController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        emailController = value;
                                      },
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: phoneController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        phoneController = value;
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
                      // Tên Và họ
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: firstNameController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        firstNameController = value;
                                      },
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: lastNameController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        lastNameController = value;
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
                      //Nơi ở
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: addressController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        addressController = value;
                                      },
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
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: wardController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        wardController = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //------------------------------------------quận

                              Row(
                                children: [
                                  Icon(Icons.my_location_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: districtController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        districtController = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //------------------------------------------thành phố

                              Row(
                                children: [
                                  Icon(Icons.location_city_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                      initialValue: cityController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.25, bottom: 0.25, left: 20),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        //labelText: "Tên",
                                      ),
                                      onChanged: (value) {
                                        cityController = value;
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //lưu
                            GestureDetector(
                              onTap: _updateUserCustomer,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
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

                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
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
