import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/widgets/AllItemWidget.dart';
import 'package:hoabactravel/widgets/RowItemWidget.dart';
import 'package:badges/badges.dart' as badges;

import '../design_home_app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 18, right: 18),
        child: Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/webInterFace.png")),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, Hieu',
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
      ),
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
                        color: Color(0xFFFFFFFF),
                        child: TextFormField(
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignHomeAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Tìm kiếm địa điểm',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Color(0xFFA2A1A1),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    const SizedBox(
                      width: 30,
                      height: 60,
                      child: Icon(Icons.search, color: Color(0xFFA2A1A1)),
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
            'Khuyến nghị',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignHomeAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        RowItemWidget(),
      ],
    );
  }

  // Tất cả dich vụ
  Widget getAllUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Tất cả',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignHomeAppTheme.darkerText,
            ),
          ),
          const SizedBox(
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
