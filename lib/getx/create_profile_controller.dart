import 'package:crafty_bay/data/model/read_profile_model.dart';
import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController{
  bool createProfileInProgress = false;
  bool readProfileInProgress = false;

  ReadProfileModel readProfileModel = Get.put(ReadProfileModel());

  Future <bool> createProfile (String firstName, String lastName, String mobile, String city, String shippingAddress) async{
    createProfileInProgress = true;
    update();
     final result = await NetworkUtils().postMethod(Urls.createProfileUrl, body: {
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'city': city,
      'shippingAddress': shippingAddress
     });
     createProfileInProgress = false;
     update();
     if (result != null && result['msg']=='success'){
      return true;
     } else {
      return false;
     }
  }

    Future <bool> ReadProfile () async{
    readProfileInProgress = true;
    update();
     final result = await NetworkUtils().getMethod(Urls.readProfileDataUrl);
     readProfileInProgress = false;
     update();
     if (result != null && result['msg']=='success'){
      readProfileModel = ReadProfileModel.fromJson(result);
      return true;
     } else {
      return false;
     }
  }

}
