import 'package:crafty_bay/data/model/cart_list_model.dart';
import 'package:crafty_bay/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../getx/cart_controller.dart';
import '../utils/utilities.dart';
import 'increment_decrement.dart';
import 'package:get/get.dart';

class CartCardList extends StatelessWidget {
  CartCardList(
      {super.key, required this.cartData, required this.onChangeValue});

  final CartData cartData;
  final Function(int, int) onChangeValue;
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(productId: cartData.product!.id!));
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Row(
            children: [
              Image.network(
                cartData.product?.image ?? '',
                height: 90,
                width: 90,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(width: 35),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cartData.product?.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        InkWell(
                            onTap: () {
                              cartController
                                  .deleteCart(cartData.id!)
                                  .then((result) {
                                if (result) {
                                  cartController.getCartList();
                                  Get.snackbar('Success!', "Delete Cart Successfull!",
                                      backgroundColor: Colors.greenAccent,
                                      snackPosition: SnackPosition.TOP,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(8.0));
                                } else {
                                  Get.snackbar('Error!', "Delete Cart Failed!",
                                      backgroundColor: Colors.redAccent,
                                      snackPosition: SnackPosition.TOP,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(8.0));
                                }
                              });
                            },
                            child: const Icon(IconlyBold.delete,
                                color: Colors.blueGrey, size: 18))
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Color: ${cartData.color}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Size: ${cartData.size}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${cartData.product?.price ?? 0}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.PrimaryColor),
                        ),
                        const Spacer(),
                        IncrementDecrement(
                          onChange: (oldValue, newValue) {
                            onChangeValue(oldValue, newValue);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
