import 'package:flutter/material.dart';
import 'package:hoabactravel/screens/forgot_pass_screen.dart';
import 'package:hoabactravel/screens/home_screen.dart';
import 'package:hoabactravel/screens/login_screen.dart';
import 'package:hoabactravel/screens/main_screen.dart';
import 'package:hoabactravel/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/" : (context) => LoginScreen(),
        "homeScreen" : (context) => const HomeScreen(),
        "loginScreen" : (context) => LoginScreen(),
        "registerScreen" : (context) => RegisterScreen(),
        "mainScreen" : (context) => const MainScreen(),
        "forgotScreen" : (context) => ForgotPassScreen(),

      },
    );
  }
}

