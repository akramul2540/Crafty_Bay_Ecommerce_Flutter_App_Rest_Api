import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:get/get.dart';
import '../data/model/category_list_model.dart';



class CategoryController extends GetxController {

 CategoryListModel categoryListModel= CategoryListModel();

 bool getCategoryListInProgress = false;

  Future <bool> getCategoryList()async{

    getCategoryListInProgress = true;
    update();
    
    final result = await NetworkUtils().getMethod(Urls.categoryListUrl);
    getCategoryListInProgress = false;
    if (result != null){
      categoryListModel = CategoryListModel.fromJson(result);
       update();
      return true;
    } else {
       update();
      return false;
    }
  }
}