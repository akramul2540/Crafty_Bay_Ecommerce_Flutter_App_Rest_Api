import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:crafty_bay/getx/user_data.dart';
import 'package:crafty_bay/getx/user_data_controller.dart';
import 'package:get/get.dart';
import '../data/model/read_profile_model.dart';

class AuthenticationController extends GetxController {
  bool authState = false;
  bool sendOtpVarificationCodetoEmailInProgress = false;
  bool varifyOtpInProgress = false;
  final UserDataController userDataController = Get.put(UserDataController());


  Future<bool> sendOtpVarificationCodetoEmail(String email) async {
    sendOtpVarificationCodetoEmailInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.sendOtpToEmailUrl(email));
    sendOtpVarificationCodetoEmailInProgress = false;
    update();
    if (response != null && response['msg'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> varifyOtp(String email, String otp) async {
    varifyOtpInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.varifyOtpUrl(email, otp));
    varifyOtpInProgress = false;
    update();
    if (response != null && response['msg'] == 'success') {
      await userDataController.WriteUserToken(response["data"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> readProfileDetails() async {
    varifyOtpInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.readProfileUrl);
    varifyOtpInProgress = false;
    update();
    if (response != null && response['msg'] == 'success') {
      ReadProfileModel readProfileModel = ReadProfileModel.fromJson(response);
      if ((readProfileModel.data?.length ?? 0) > 0) {
        Data profileData = readProfileModel.data!.first;
        UserDetails userDetails = UserDetails(
            profileData.firstName ?? '',
            profileData.lastName ?? '',
            profileData.mobile ?? '',
            profileData.shippingAddress ?? '',
            profileData.email!,
            profileData.city ?? '',
            profileData.id!);
        userDataController.WriteUserData(userDetails);
        return true;
      } else {
        update();
        return false;
      }
    } else {
      return false;
    }
  }
}
