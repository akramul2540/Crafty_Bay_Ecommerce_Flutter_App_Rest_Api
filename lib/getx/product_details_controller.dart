import 'package:get/get.dart';
import '../data/model/products_details_model.dart';
import '../data/network_utils.dart';
import '../data/urls.dart';

class ProductDetailsController extends GetxController{

  ProductDetailsModel productDetailsModel = ProductDetailsModel();

  bool productDetailsInProgress = false;

  
  Future<bool> getProductsDetailsById(int productId) async {
    productDetailsInProgress = true;
    update();
    final response = await NetworkUtils()
        .getMethod(Urls.ProductDetailsByIdUrl(productId));
    productDetailsInProgress = false;
    if (response != null && response['msg'] == 'success') {
      productDetailsModel = ProductDetailsModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

}