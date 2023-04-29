import 'package:crafty_bay/ui/onboarding/create_profile_screen.dart';
import 'package:crafty_bay/ui/onboarding/email_varification_screen.dart';
import 'package:crafty_bay/ui/onboarding/splash_screen.dart';
import 'package:crafty_bay/ui/screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationScreen(),
    );
  }
}
