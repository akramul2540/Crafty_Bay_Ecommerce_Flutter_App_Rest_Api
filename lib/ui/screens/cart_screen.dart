import 'package:crafty_bay/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getx/cart_controller.dart';
import '../../widgets/cart_card_list.dart';
import 'bottom_nav_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController productCountEditingController = TextEditingController();
  final CartController cartController = Get.put(CartController());
  

  @override
  void initState() {
    super.initState();
     cartController.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){Get.offAll(const BottomNavigationScreen());},padding: EdgeInsets.zero, icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
        title: const Text('Cart', style: TextStyle(color: Colors.black),),),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          if (cartController.getCartListInProgress){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                      itemCount: cartController.cartListModel.data?.length?? 0,
                      itemBuilder: ((context, index) {
                      return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                child: CartCardList(cartData: cartController.cartListModel.data![index], onChangeValue: (int oldCount, int newCount) {
                  final prouctPrice = double.tryParse(cartController.cartListModel.data![index].product?.price?? '')?? 0.0;
                  cartController.totalPrice -= (oldCount * prouctPrice);
                  final subTotalPrice = newCount * prouctPrice;
                  cartController.totalPrice += subTotalPrice;
                  setState(() {});
                  },)
                      );
                    })),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.PrimaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Price', style: TextStyle(fontWeight: FontWeight.w400),),
                        Text('\$${cartController.totalPrice}', style: TextStyle(fontWeight: FontWeight.w800, color: AppColor.PrimaryColor),),
                        // DropdownButton(items: const [
                        //   DropdownMenuItem(child: Text('Apple')),
                        //   DropdownMenuItem(child: Text('Tomatto')),
                        //   DropdownMenuItem(child: Text('Benana')),
                        //   DropdownMenuItem(child: Text('Orange')),
                        // ], onChanged: ((value) {
                        // }))
                      ]
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColor.PrimaryColor),
                        onPressed: (){}, child: const Text('Checkout', style: TextStyle(color: Colors.white),)))
                  ],
                ),
              )
            ],
          );
        }
      )
    );
  }
}


