import 'package:crafty_bay/data/model/product_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../getx/product_review_controller.dart';

class ReviewsCardItem extends StatelessWidget {
   ReviewsCardItem({super.key, required this.reviewData});

  final ReviewData reviewData;
  final ProductReviewController productReviewController = Get.put(ProductReviewController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.blueGrey.withOpacity(0.3),
                    child: const Icon(IconlyBold.profile, color: Colors.white,size: 16,),
                  ),
                  const SizedBox(width: 8.0),
                   Text((reviewData.profile!.firstName?? '')+' '+(reviewData.profile!.lastName?? ''), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                ],
              ),
              const SizedBox(height: 8.0),
               Text(reviewData.description?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.blueGrey),textAlign: TextAlign.start,),
            ],
          ),
        ),
      ),
    );
  }
}