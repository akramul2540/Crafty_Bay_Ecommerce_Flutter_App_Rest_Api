import 'dart:convert';
import 'package:crafty_bay/getx/user_data.dart';
import 'package:crafty_bay/ui/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui/onboarding/email_varification_screen.dart';

class UserDataController extends GetxController{
  UserDetails? userDetails;
  String? userToken;

  Future<void> WriteUserData(UserDetails uDetails) async {
  final Prefs = await SharedPreferences.getInstance();
  await Prefs.setString("user", jsonEncode(uDetails.toJson()));
  userDetails = uDetails;
}

  Future<String?> ReadUserData() async {
  final Prefs = await SharedPreferences.getInstance();
  String user = Prefs.getString("user")?? '';
  UserDetails  userDetails = UserDetails.fromJson(jsonDecode(user));
}

  Future<void> WriteUserToken(String token) async {
  final Prefs = await SharedPreferences.getInstance();
  await Prefs.setString("token", token);
  userToken = token;
}

  Future<String?> ReadUsertoken() async {
  final Prefs = await SharedPreferences.getInstance();
  userToken = Prefs.getString('token');
}

void redirectUnAuthenticateUser() {
    Get.to(const EmailVarificationScreen());
  }

  bool checkAuthState() {
    if (userToken == null) {
      redirectUnAuthenticateUser();
      return false;
    }
    return true;
  }


  Future <void> Logout ()async{
    userToken = null;
    userDetails = null;
    final Prefs = await SharedPreferences.getInstance();
    await Prefs.clear();
  }

}