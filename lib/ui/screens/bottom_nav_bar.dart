import 'package:crafty_bay/getx/bottom_navigation_controller.dart';
import 'package:crafty_bay/ui/screens/cart_screen.dart';
import 'package:crafty_bay/ui/screens/categories_screen.dart';
import 'package:crafty_bay/ui/screens/home_screen.dart';
import 'package:crafty_bay/ui/screens/wish_screen.dart';
import 'package:crafty_bay/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../getx/category_controller.dart';
import '../../getx/home_controller.dart';
import '../../getx/product_controller.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

BottomNavigationController controller = Get.put(BottomNavigationController());

  homeController HomeController = Get.put(homeController());
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());
  

final pages = const [
  HomePage(),
  CategoryPage(),
  CartPage(),
  WishListPage()
];

  @override
  void initState() {
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    HomeController.getProductSlider();
    categoryController.getCategoryList();
    productController.getPopularProducts();
    productController.getSpecialProducts();
    productController.getNewProducts();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GetBuilder<BottomNavigationController>(
          builder: (controller) {
            return BottomNavigationBar(
              elevation: 20,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColor.PrimaryColor,
              unselectedItemColor: Colors.blueGrey,
              currentIndex: controller.selectedIndex,
              onTap: (index) {
                controller.changeIndex(index);
              },
              items: [
              BottomNavigationBarItem(label: 'Home', icon: Icon(controller.selectedIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home)),
              BottomNavigationBarItem(label: 'Categories', icon: Icon(controller.selectedIndex == 1
                          ? IconlyBold.category
                          : IconlyLight.category)),
              BottomNavigationBarItem(label: 'Cart', icon: Icon(controller.selectedIndex == 2
                          ? IconlyBold.buy
                          : IconlyLight.buy)),
              BottomNavigationBarItem(label: 'Wish', icon: Icon(controller.selectedIndex == 3
                          ? IconlyBold.heart
                          : IconlyLight.heart)),
            ]);
          }
        ),
        body: GetBuilder<BottomNavigationController>(
          builder: (controller) {
            return pages[controller.selectedIndex];
          }
        ));
  }
}
