import 'package:crafty_bay/getx/user_data_controller.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  int selectedIndex = 0;

final UserDataController userDataController = Get.put(UserDataController());

  void changeIndex (int index) {
    if (index == 2 || index == 3){
      if (!userDataController.checkAuthState()){
        return;
      }
    }
    selectedIndex = index;
    update();
  }
}