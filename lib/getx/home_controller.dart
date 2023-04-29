import 'package:crafty_bay/data/model/product_slider_model.dart';
import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:get/get.dart';



class homeController extends GetxController {

 ProductSliderModel productSliderModel= ProductSliderModel();

 bool getProductSliderInProgress = false;

  Future <bool> getProductSlider()async{

    getProductSliderInProgress = true;
    update();
    
    final result = await NetworkUtils().getMethod(Urls.productSliderUrl);
    getProductSliderInProgress = false;
    if (result != null){
      productSliderModel = ProductSliderModel.fromJson(result);
       update();
      return true;
    } else {
       update();
      return false;
    }
  }
}