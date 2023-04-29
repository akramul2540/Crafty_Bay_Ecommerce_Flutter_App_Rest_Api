import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../getx/user_data_controller.dart';
import '../../utils/utilities.dart';
import '../screens/bottom_nav_bar.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  
  final UserDataController userDataController = Get.put(UserDataController());

  @override
  void initState() {
    super.initState();
    userDataController.ReadUsertoken().then((_){
      if (userDataController.userToken != null){
    userDataController.ReadUserData();
      }
    });
    
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAll(const BottomNavigationScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/images/logo_2.svg',
            fit: BoxFit.contain,
          ),
          const Spacer(),
          CircularProgressIndicator(
            color: AppColor.PrimaryColor,
          ),
          const SizedBox(height: 10),
          const Text(
            'version 1.0',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.6,
                color: Colors.grey),
          ),
          const SizedBox(height: 30),
        ],
      ),
    ));
  }
}
