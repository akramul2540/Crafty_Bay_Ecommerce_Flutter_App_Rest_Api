import 'package:crafty_bay/getx/user_data_controller.dart';
import 'package:crafty_bay/ui/onboarding/create_profile_screen.dart';
import 'package:crafty_bay/ui/screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../getx/authentication_controller.dart';
import '../../utils/utilities.dart';
import '../../widgets/reusable_elaveted_button.dart';
import 'package:get/get.dart';

class OTPVarificationScreen extends StatefulWidget {
  const OTPVarificationScreen({super.key, required this.email});
  final String email;

  @override
  State<OTPVarificationScreen> createState() => _OTPVarificationScreenState();
}

class _OTPVarificationScreenState extends State<OTPVarificationScreen> {
  final AuthenticationController authController =
      Get.put(AuthenticationController());
  final TextEditingController pinCodeTextEditingController =
      TextEditingController();
  final _otpFormKey = GlobalKey<FormState>();
  final UserDataController userDataController = Get.put(UserDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _otpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_2.svg',
                    fit: BoxFit.scaleDown,
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    "Enter OTP Code",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    "A 4 digit code has been sent",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  PinCodeTextField(
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter Correct OTP';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      inactiveFillColor: AppColor.PrimaryColor,
                      inactiveColor: AppColor.PrimaryColor,
                      errorBorderColor: Colors.red,
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    controller: pinCodeTextEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                    appContext: context,
                  ),
                  const SizedBox(height: 8.0),
                  GetBuilder<AuthenticationController>(
                      builder: (authController) {
                    if (authController.varifyOtpInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ReusableElevatedButton(
                      onTap: () async {
                        authController.varifyOtp(widget.email, pinCodeTextEditingController.text).then((result){
                          if (result){
                            authController.readProfileDetails().then((value){
                              if (value){
                                Get.offAll(const BottomNavigationScreen());
                              } else {
                                Get.offAll(const CreateProfileScreen());
                              }
                            });
                          } else {
                             Get.snackbar('Error', "Request Failed! Try Again",
                                backgroundColor: Colors.redAccent,
                                snackPosition: SnackPosition.TOP,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(8.0));
                          }
                        });
                      },
                      text: 'Next',
                    );
                  }),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(
                          text: 'This code will expire in ',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          children: [
                        TextSpan(
                            text: '120s',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppColor.PrimaryColor))
                      ])),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Resend Code',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

