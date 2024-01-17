import 'package:flutter/material.dart';
import 'package:hoabactravel/screens/book_ticket_screen.dart';
import 'package:hoabactravel/screens/forgot_pass_screen.dart';
import 'package:hoabactravel/screens/home_screen.dart';
import 'package:hoabactravel/screens/login_screen.dart';
import 'package:hoabactravel/screens/main_screen.dart';
import 'package:hoabactravel/screens/register_screen.dart';
import 'package:hoabactravel/screens/splash_screen.dart';
import 'package:hoabactravel/utils/LoginProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LoginProvider(),

    child: MyApp(),
  ),);
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
        "/" : (context) => Splashs(),
        "homeScreen" : (context) => const HomeScreen(),
        "loginScreen" : (context) => LoginScreen(),
        "registerScreen" : (context) => RegisterScreen(),
        "mainScreen" : (context) => const MainScreen(),
        "forgotScreen" : (context) => ForgotPassScreen(),


      },
    );
  }
}

