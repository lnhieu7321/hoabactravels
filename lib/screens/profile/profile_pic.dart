import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/ProfileHomeModel.dart';
import 'package:http/http.dart' as http;
import '../../utils/LoginProvider.dart';

class ProfilePic extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {



  Future<ProfileHome?> fetchProfile() async {
    String? userId = context.watch<LoginProvider>().userId;
    try {
      final response = await http.get(Uri.parse(baseURL + '/apiprofilehome.php?id=$userId'));

      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        return ProfileHome.fromJson(profileData);
      } else {
        throw Exception('Error fetching profile hieu: ${response.body}');
      }
    } catch (error) {
      print('Error fetching profile: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileHome?>(
      future: fetchProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final profile = snapshot.data!;
          return  Container(
            height: 120,
            width: double.infinity,
            child: Column(
              children: [
                if (profile.logo != null)
                CircleAvatar(
                  radius:40.0,
                backgroundImage: NetworkImage(profile.logo!)),
                Text(profile.name , style: TextStyle(fontSize: 20),),
                Text(profile.email)
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }
}
