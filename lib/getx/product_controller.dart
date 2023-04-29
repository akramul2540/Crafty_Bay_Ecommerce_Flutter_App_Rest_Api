import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:get/get.dart';
import '../data/model/product_remark_model.dart';

class ProductController extends GetxController {
  ProductRemarkModel popularProductsRemarkModel = ProductRemarkModel();
  ProductRemarkModel specialProducsRemarkModel = ProductRemarkModel();
  ProductRemarkModel newProductsRemarkModel = ProductRemarkModel();
  ProductRemarkModel productsByCategoryModel = ProductRemarkModel();
  

  bool popularProductsInProgress = false;
  bool specialProductsInProgress = false;
  bool newProductsInProgress = false;
  bool productsByCategoryInProgress = false;
  bool productDetailsInProgress = false;

  Future<bool> getPopularProducts() async {
    popularProductsInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.ProductListByRemarkUrl('popular'));
    popularProductsInProgress = false;
    if (response != null && response['msg'] == 'success') {
      popularProductsRemarkModel = ProductRemarkModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  Future<bool> getSpecialProducts() async {
    specialProductsInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.ProductListByRemarkUrl('special'));
    specialProductsInProgress = false;
    if (response != null && response['msg'] == 'success') {
      specialProducsRemarkModel = ProductRemarkModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  Future<bool> getNewProducts() async {
    newProductsInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.ProductListByRemarkUrl('new'));
    newProductsInProgress = false;
    if (response != null && response['msg'] == 'success') {
      newProductsRemarkModel = ProductRemarkModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  Future<bool> getProductsByCategory(String categoryId) async {
    productsByCategoryInProgress = true;
    update();
    final response = await NetworkUtils()
        .getMethod(Urls.ProductListByCategoryUrl(categoryId));
    productsByCategoryInProgress = false;
    if (response != null && response['msg'] == 'success') {
      productsByCategoryModel = ProductRemarkModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

}
