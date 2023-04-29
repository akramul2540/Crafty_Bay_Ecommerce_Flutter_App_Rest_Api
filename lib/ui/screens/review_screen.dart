import 'package:crafty_bay/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getx/product_review_controller.dart';
import '../../getx/user_data_controller.dart';
import '../../utils/utilities.dart';
import '../../widgets/reviews_card.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.productId});
  
  final int productId;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  final UserDataController userDataController = Get.put(UserDataController());
  final ProductReviewController productReviewController= Get.put(ProductReviewController());

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productReviewController.getProductReview(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.offAll(ProductDetailsScreen(productId: productReviewController.productReviewModel.data!.first.productId?? 0));
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: const Text(
            'Reviews',
            style: TextStyle(color: Colors.black),
          ),
        ),
      body: GetBuilder<ProductReviewController>(
        builder: (productReviewController) {
          if (productReviewController.productReviewInprogress){
            return const Center(child: CircularProgressIndicator(),);
          }
          if ((productReviewController.productReviewModel.data?.length?? 0) == 0){
                return Column(
                  children: [
                    const Spacer(),
                    const Center(
                  child: Text('This Product has no review'),
                ),
                const Spacer(),
                Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.PrimaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Reviews ', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: ('(${productReviewController.productReviewModel.data?.length.toString()?? 0})')
                          )
                        ]
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      height: 30,
                      child: FloatingActionButton(
                        backgroundColor: AppColor.PrimaryColor,
                        onPressed: (){final bool _authState = userDataController.checkAuthState();
                                    if (_authState){
                                      Get.to(const CreateReviewPage());
                                    }}, child: const Icon(Icons.add)))
                  ],
                ),
              )
                  ],
                );}
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: productReviewController.productReviewModel.data?.length?? 0,
                  itemBuilder: (context, index) {
                  return ReviewsCardItem(reviewData: productReviewController.productReviewModel.data![index],);
                },),
              ),
                          Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.PrimaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Reviews ', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: ('(${productReviewController.productReviewModel.data?.length.toString()?? 0})')
                          )
                        ]
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      height: 30,
                      child: FloatingActionButton(
                        backgroundColor: AppColor.PrimaryColor,
                        onPressed: (){final bool _authState = userDataController.checkAuthState();
                                    if (_authState){
                                      Get.to(const CreateReviewPage());
                                    }}, child: const Icon(Icons.add)))
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}