import 'package:crafty_bay/data/network_utils.dart';
import 'package:crafty_bay/data/urls.dart';
import 'package:get/get.dart';
import '../data/model/product_review_model.dart';


class ProductReviewController extends GetxController {

ProductReviewModel productReviewModel = Get.put(ProductReviewModel());
 bool productReviewInprogress = false;
 bool createReviewInprogress = false;

 Future <bool> getProductReview(int productId)async{
 productReviewInprogress = true;
 update();
 final result = await NetworkUtils().getMethod(Urls.productReviewUrl(productId));
 productReviewInprogress = false;
 if (result != null && result['msg']== 'success'){
  productReviewModel = ProductReviewModel.fromJson(result);
  update();
  return true;
 } else {
  update();
  return false;
 }
 }


  Future <bool> createProductReview(int productId, String description) async {
 createReviewInprogress = true;
 update();
 final result = await NetworkUtils().postMethod(Urls.createReviewListUrl, body: {
  "description": description,
  "product_id": productId.toString()
 });
 createReviewInprogress = false;
 if (result != null && result['msg']== 'success'){
  update();
  return true;
 } else {
  update();
  return false;
 }
 }
 

}
