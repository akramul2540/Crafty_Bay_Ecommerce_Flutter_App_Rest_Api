import 'package:crafty_bay/ui/screens/review_screen.dart';
import 'package:crafty_bay/widgets/reusable_elaveted_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getx/product_review_controller.dart';
import '../../widgets/text_form_field_decoration.dart';

class CreateReviewPage extends StatefulWidget {
  const CreateReviewPage({super.key});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final ProductReviewController productReviewController =
      Get.put(ProductReviewController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reviewTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.offAll(ReviewPage(
                productId: productReviewController
                        .productReviewModel.data!.first.productId ??
                    0,
              ));
            },
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text(
          'Create Reviews',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Correct First Name';
                      } else {
                        return null;
                      }
                    },
                    controller: TextEditingController(),
                    hintText: 'First Name',
                  ),
                  const SizedBox(height: 10),
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Correct Last Name';
                      } else {
                        return null;
                      }
                    },
                    controller: TextEditingController(),
                    hintText: 'Last Name',
                  ),
                  const SizedBox(height: 10),
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                        return 'Enter your review here';
                      } else {
                        return null;
                      }
                    },
                    controller: reviewTextController,
                    hintText: 'Write Review',
                    maxLines: 6,
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ProductReviewController>(
                      builder: (productReviewController) {
                    if (productReviewController.createReviewInprogress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ReusableElevatedButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            productReviewController.createProductReview(
                                productReviewController.productReviewModel.data!
                                        .first.productId ??
                                    0,
                                reviewTextController.text.trim());
                            Get.snackbar(
                                'Success!', "Review Submission Successfull!",
                                backgroundColor: Colors.greenAccent,
                                snackPosition: SnackPosition.TOP,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(8.0));
                                Get.to(ReviewPage(productId: productReviewController.productReviewModel.data!.first.productId?? 0));
                          } else {
                            Get.snackbar(
                                'Error!', "Review Submission failed! Try Again",
                                backgroundColor: Colors.redAccent,
                                snackPosition: SnackPosition.TOP,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(8.0));
                          }
                        },
                        text: 'Submit');
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
