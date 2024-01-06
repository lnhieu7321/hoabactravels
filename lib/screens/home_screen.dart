import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hoabactravel/screens/login_screen.dart';
import 'package:hoabactravel/screens/search_screen.dart';
import 'package:hoabactravel/widgets/AllItemWidget.dart';
import 'package:hoabactravel/widgets/RowItemWidget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';
import '../design_home_app_theme.dart';
import '../models/ProfileHomeModel.dart';
import '../utils/LoginProvider.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
    fetchProfile();
  }




  Future<ProfileHome?> fetchProfile() async {
    final userId = context.watch<LoginProvider>().userId;
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
    return SafeArea(
      child: Container(
        color: DesignHomeAppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F5FA),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        getSearchBarUI(),
                        getPopularUI(),
                        Flexible(
                          child: getAllUI(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AppBarProflie

  Widget getAppBarUI() {

    return FutureBuilder<ProfileHome?>(

      future: fetchProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final profile = snapshot.data!;
          return  Padding(
            padding: EdgeInsets.only(top: 20, left: 18, right: 18),
            child: Row(
              children: <Widget>[
                if (profile.logo != null)
                CircleAvatar(
                    backgroundImage: NetworkImage(profile.logo!)),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hi, ${profile.name}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          letterSpacing: 0.2,
                          color: DesignHomeAppTheme.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Bạn đang tìm kiếm một chuyến đi?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.27,
                          color: DesignHomeAppTheme.darkerText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    showBadge: true,
                    ignorePointer: false,
                    onTap: () {},
                    badgeContent:
                    Text("3", style: TextStyle(color: Colors.white),),

                    child: Icon(CupertinoIcons.bell),
                  ),

                ),

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

  //HeaderSearch

  Widget getSearchBarUI() {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 54,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F5FA),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Color(0xFFF2F5FA),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          ); },
                          style: TextButton.styleFrom(
                            backgroundColor: DesignHomeAppTheme.nearlyWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Adjust as needed
                              side: BorderSide(
                                color: Colors.grey, // Adjust color as needed
                                width: 1.0, // Adjust width as needed
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.search, color: DesignHomeAppTheme.nearlyBlue,),
                              SizedBox(width: 10,),
                              Text("Tìm kiếm địa điểm", style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: DesignHomeAppTheme.nearlyBlue,
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

// Dịch vụ phổ biến
  Widget getPopularUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Phổ biến',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignHomeAppTheme.darkerText,
            ),
          ),
        ),

        RowItemWidget(),
      ],
    );
  }

  // Tất cả dich vụ
  Widget getAllUI() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tất cả!',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignHomeAppTheme.darkerText,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Flexible(
            child: AllItemWidget(),
          ),
        ],
      ),
    );
  }
}