import 'package:crafty_bay/getx/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/product_card_list.dart';
import 'bottom_nav_bar.dart';


class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key, required this.categoryId, required this.categoryName});

  final String categoryId;
  final String categoryName;

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {

  ProductController productController = Get.put(ProductController());

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productController.getProductsByCategory(widget.categoryId);
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
                Get.offAll(const BottomNavigationScreen());
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            widget.categoryName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<ProductController>(
          builder: (productController) {
            if (productController.productsByCategoryInProgress){
              return const Center(child: CircularProgressIndicator());}
              if ((productController.productsByCategoryModel.data?.length?? 0) == 0){
                return const Center(
                  child: Text('No Products'),
                );
              }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 5/6,
                      crossAxisCount: 3),
                  itemCount: productController.productsByCategoryModel.data?.length?? 0,
                  itemBuilder: (context, index) {
                    return ProductCardItem(productData: productController.productsByCategoryModel.data![index],);
                  }),
            );
            }
          
        )
        );
  }
}