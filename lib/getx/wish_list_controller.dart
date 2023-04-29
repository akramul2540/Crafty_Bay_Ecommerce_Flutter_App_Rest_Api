import 'package:crafty_bay/data/model/product_wish_list_model.dart';
import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:get/get.dart';
import '../data/model/create_wishlist_model.dart';


class WishListController extends GetxController{

  bool wishListInProgress = false;
  bool createWishListInProgress = false;
  ProductWishLIstModel productWishListModel = Get.put(ProductWishLIstModel());
  CreateWishLIstModel createWishLIstModel  = Get.put(CreateWishLIstModel());

Future <bool> getProductWishList ()async{
  wishListInProgress = true;
  update();
  final result = await NetworkUtils().getMethod(Urls.productWishListUrl);
  wishListInProgress = false;
  if (result != null && result['msg']=='success'){
    productWishListModel = ProductWishLIstModel.fromJson(result);
    update();
    return true;
  } else {
    return false;
  }
}


Future <bool> createProductWishList (int productId) async {
  createWishListInProgress = true;
  update();
  final result = await NetworkUtils().getMethod(Urls.createWishListUrl(productId));
  createWishListInProgress = false;
  if (result != null && result['msg']=='success'){
    createWishLIstModel = CreateWishLIstModel.fromJson(result);
    update();
    return true;
  } else {
    return false;
  }
}

}