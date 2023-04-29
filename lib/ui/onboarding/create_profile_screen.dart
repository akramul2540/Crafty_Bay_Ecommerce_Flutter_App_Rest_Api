import 'package:crafty_bay/data/model/read_profile_model.dart';
import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/getx/user_data.dart';
import 'package:crafty_bay/ui/screens/bottom_nav_bar.dart';
import 'package:crafty_bay/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../getx/create_profile_controller.dart';
import '../../getx/user_data_controller.dart';
import '../../widgets/reusable_elaveted_button.dart';
import '../../widgets/text_form_field_decoration.dart';
import 'package:get/get.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController firstNameEditingController =
      TextEditingController();
  final TextEditingController lastNameEditingController =
      TextEditingController();
  final TextEditingController mobileEditingController = TextEditingController();
  final TextEditingController cityEditingController = TextEditingController();
  final TextEditingController shippingAddressEditingController =
      TextEditingController();

  final UserDataController userDataController = Get.put(UserDataController());
  final CreateProfileController createProfileController =
      Get.put(CreateProfileController());
  final _formKey = GlobalKey<FormState>();

  getUserData ()async{
  final readData = await userDataController.ReadUserData();
  UserDetails(firstNameEditingController.text, lastNameEditingController.text, mobileEditingController.text, shippingAddressEditingController.text, "emial", cityEditingController.text, identityHashCode('object'));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   userDataController.ReadUserData();
  //   firstNameEditingController.text = userDataController.userDetails!.firstName.toString();
  //   lastNameEditingController.text = userDataController.userDetails!.lastName;
  //   mobileEditingController.text = userDataController.userDetails!.mobile;
  //   cityEditingController.text = userDataController.userDetails!.city;
  //   shippingAddressEditingController.text =
  //       userDataController.userDetails!.shippingAddress;
    // createProfileController.ReadProfile();
    // firstNameEditingController.text = createProfileController
    //     .readProfileModel.data!.first.firstName
    //     .toString();
    // lastNameEditingController.text = createProfileController
    //     .readProfileModel.data!.first.lastName
    //     .toString();
    // mobileEditingController.text =
    //     createProfileController.readProfileModel.data!.first.mobile.toString();
    // cityEditingController.text =
    //     createProfileController.readProfileModel.data!.first.city.toString();
    // shippingAddressEditingController.text = createProfileController
    //     .readProfileModel.data!.first.shippingAddress
    //     .toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
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
                    "Complete Profile",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    "Get started with us with your details",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Correct First Name';
                      } else {
                        return null;
                      }
                    },
                    controller: firstNameEditingController,
                    hintText: 'First Name',
                  ),
                  const SizedBox(height: 8.0),
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Correct Last Name';
                      } else {
                        return null;
                      }
                    },
                    controller: lastNameEditingController,
                    hintText: 'Last Name',
                  ),
                  const SizedBox(height: 8.0),
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                              .hasMatch(value)) {
                        return 'Enter Correct Mobile Number';
                      } else {
                        return null;
                      }
                    },
                    controller: mobileEditingController,
                    hintText: 'Mobile',
                  ),
                  const SizedBox(height: 8.0),
                  ReusableTextFormField(
                    controller: cityEditingController,
                    hintText: 'City',
                  ),
                  const SizedBox(height: 8.0),
                  ReusableTextFormField(
                    controller: shippingAddressEditingController,
                    maxLines: 3,
                    hintText: 'Shipping Address',
                  ),
                  const SizedBox(height: 12),
                  GetBuilder<CreateProfileController>(
                      builder: (createProfileController) {
                    if (createProfileController.createProfileInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ReusableElevatedButton(
                      onTap: () {
                        Get.to(const HomePage());
                      },
                      text: 'Complete',
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


                      // firstNameEditingController.text =
                      //     userDataController.userDetails!.firstName;
                      // lastNameEditingController.text =
                      //     userDataController.userDetails!.lastName;
                      // mobileEditingController.text =
                      //     userDataController.userDetails!.mobile;
                      // cityEditingController.text =
                      //     userDataController.userDetails!.city;
                      // shippingAddressEditingController.text =
                      //     userDataController.userDetails!.shippingAddress;
                      // if (_formKey.currentState!.validate()) {
                      //   Get.to(const BottomNavigationScreen());
                      // } else {
                      //   Get.snackbar('Error!', "complete your profile first",
                      //       backgroundColor: Colors.redAccent,
                      //       snackPosition: SnackPosition.TOP,
                      //       colorText: Colors.white,
                      //       margin: const EdgeInsets.all(8.0));
                      // }



                        //                       if (){

                        // }
                        // else if (_formKey.currentState!.validate()) {
                        //   createProfileController.createProfile(
                        //       firstNameEditingController.text.trim(),
                        //       lastNameEditingController.text.trim(),
                        //       mobileEditingController.text.trim(),
                        //       cityEditingController.text.trim(),
                        //       shippingAddressEditingController.text.trim());
                        // }