import 'package:crafty_bay/ui/onboarding/email_varification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getx/user_data_controller.dart';
import '../../getx/wish_list_controller.dart';
import '../../widgets/product_card_list.dart';
import '../../widgets/wish_list_card.dart';
import 'bottom_nav_bar.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishListController wishListController = Get.put(WishListController());
  final UserDataController userDataController = Get.put(UserDataController());


   checkAuthStateTo ()async{
     final bool authState = userDataController.checkAuthState();
    if (authState) {
      await wishListController.getProductWishList();
    } else {
      Get.offAll(const EmailVarificationScreen());
    }
   }

  @override
  void initState() {
    super.initState();
    checkAuthStateTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.offAll(const BottomNavigationScreen());
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: const Text(
            'WishList',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<WishListController>(builder: (wishListController) {
          if (wishListController.wishListInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 5 / 6, crossAxisCount: 3),
                itemCount: wishListController.productWishListModel.data!.length,
                itemBuilder: (context, index) {
                  return WishListProductCardItem(
                    wishListData:
                        wishListController.productWishListModel.data![index],
                  );
                }),
          );
        }));
  }
}
