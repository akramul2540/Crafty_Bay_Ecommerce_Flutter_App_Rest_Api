import 'package:crafty_bay/getx/home_controller.dart';
import 'package:crafty_bay/getx/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../getx/bottom_navigation_controller.dart';
import '../../getx/category_controller.dart';
import '../../getx/product_controller.dart';
import '../../widgets/all_product_category_list.dart';
import '../../widgets/home_banner_slider.dart';
import '../../widgets/product_card_list.dart';
import 'all_product_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavigationController controller = Get.put(BottomNavigationController());
  UserDataController userDataController = Get.put(UserDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/images/logo_nav.svg',
          fit: BoxFit.scaleDown,
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: const Icon(
              IconlyLight.profile,
              size: 20,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: const Icon(
              IconlyLight.call,
              size: 20,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: const Icon(
              IconlyLight.notification,
              size: 20,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 10),
          Center(
            child: InkWell(
              onTap: ()async{
                if (userDataController.userToken != null){
                await userDataController.Logout();
                userDataController.redirectUnAuthenticateUser();
        }
              },
              child: const Text('Logout', style: TextStyle(color: Colors.blueAccent),)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        IconlyLight.search,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide.none)),
                ),
                const SizedBox(height: 12.0),
                GetBuilder<homeController>(builder: (HomeController) {
                  if (HomeController.getProductSliderInProgress) {
                    return const CircularProgressIndicator();
                  } else {
                    return BannerSlider(
                        productSliderModel: HomeController.productSliderModel);
                  }
                }),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Categories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.changeIndex(1);
                        },
                        child: const Text('See All'))
                  ],
                ),
                GetBuilder<CategoryController>(builder: (categoryController) {
                  if (categoryController.getCategoryListInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: categoryController
                                  .categoryListModel.data?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return categoriesItem(
                              categoreyItemName: categoryController
                                      .categoryListModel
                                      .data![index]
                                      .categoryName ??
                                  '',
                              onTap: () {
                                Get.to(AllProductPage(
                                  categoryName: categoryController.categoryListModel.data![index].categoryName?? '',
                                  categoryId: '${categoryController.categoryListModel.data![index].id?? 1}'));
                              },
                              image: categoryController.categoryListModel
                                      .data![index].categoryImg ??
                                  '',
                            );
                          },
                        ));
                  }
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          // Get.to(const AllProductPage());
                        },
                        child: const Text('See All'))
                  ],
                ),
                GetBuilder<ProductController>(builder: (productController) {
                  if (productController.popularProductsInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController
                                .popularProductsRemarkModel.data?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return ProductCardItem(
                              productData: productController
                                  .popularProductsRemarkModel.data![index]);
                        },
                      ),
                    );
                  }
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Special',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          // Get.to(const AllProductPage());
                        },
                        child: const Text('See All'))
                  ],
                ),
                const SizedBox(height: 10),
                GetBuilder<ProductController>(builder: (productController) {
                  if (productController.specialProductsInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController
                                .specialProducsRemarkModel.data?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return ProductCardItem(
                              productData: productController
                                  .specialProducsRemarkModel.data![index]);
                        },
                      ),
                    );
                  }
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          // Get.to(const AllProductPage());
                        },
                        child: const Text('See All'))
                  ],
                ),
                const SizedBox(height: 10),
                GetBuilder<ProductController>(builder: (productController) {
                  if (productController.newProductsInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController
                                .newProductsRemarkModel.data?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return ProductCardItem(
                            productData: productController
                                .newProductsRemarkModel.data![index],
                          );
                        },
                      ),
                    );
                  }
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
