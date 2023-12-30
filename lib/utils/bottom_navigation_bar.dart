import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hoabactravel/screens/history_screen.dart';
import 'package:hoabactravel/screens/home_screen.dart';
import 'package:hoabactravel/screens/user_screen.dart';
import 'package:hoabactravel/screens/wallet_screen.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int index = 0;
  final screens =[
    HomeScreen(),
    HistoryScreen(),
    UserScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              selectedIndex: index,
              onTabChange: (index) =>
                  setState(() {
                    this.index = (index);
                  }),
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Color(0xFF93D334),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.compass,
                  text: 'Trang chủ',
                ),

                GButton(
                  icon: LineIcons.history,
                  text: 'Đặt chỗ của tôi',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Hồ sơ',
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
