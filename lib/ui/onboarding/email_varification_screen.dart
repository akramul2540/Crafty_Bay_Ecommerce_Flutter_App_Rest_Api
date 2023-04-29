import 'package:crafty_bay/getx/authentication_controller.dart';
import 'package:crafty_bay/ui/onboarding/otp_varification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/reusable_elaveted_button.dart';
import '../../widgets/text_form_field_decoration.dart';
import 'package:get/get.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  final AuthenticationController authController =
      Get.put(AuthenticationController());
  final TextEditingController emailVarificationController =
      TextEditingController();

final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    "Please Enter Your Email Address",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  ReusableTextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,5}').hasMatch(value)) {
                          return 'Enter Correct Email';
                        } else {
                          return null;
                        }
                      },
                      controller: emailVarificationController,
                      hintText: 'Email Address'),
                  const SizedBox(height: 12),
                  GetBuilder<AuthenticationController>(
                      builder: (authController) {
                    if (authController
                        .sendOtpVarificationCodetoEmailInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ReusableElevatedButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()){
                        authController
                            .sendOtpVarificationCodetoEmail(
                                emailVarificationController.text.trim())
                            .then((value) =>
                                Get.to(OTPVarificationScreen(email: emailVarificationController.text.trim()),));
                      }
                      },
                      text: 'Next',
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
