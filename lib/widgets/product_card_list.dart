import 'package:crafty_bay/data/model/product_remark_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../ui/screens/product_details_screen.dart';
import '../utils/utilities.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key,
    required this.productData,
  });

  final Data productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(productId: productData.id?? 0));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: Column(
          children: [
            Flexible(child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(6.0), topLeft: Radius.circular(6.0)), 
                color: AppColor.PrimaryColor.withOpacity(0.2)
              ),
              child: Image.network(
              productData.image ?? '',
              height: 100,
              width: 130,
              fit: BoxFit.scaleDown,
            ),
            )),
            const SizedBox(height: 4,),
            Text(
              productData.title ?? '',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 7.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${productData.price}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.PrimaryColor),
                ),
                const SizedBox(width: 10),
                const Icon(
                  IconlyLight.star,
                  color: Color(0xffFFD700),
                  size: 12,
                ),
                Text(
                  '${productData.star ?? 0.0}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 10),
                InkWell(
                    onTap: () {},
                    child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                            color: AppColor.PrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          IconlyLight.heart,
                          size: 12,
                          color: Colors.white,
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
