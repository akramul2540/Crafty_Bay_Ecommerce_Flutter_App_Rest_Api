import 'package:crafty_bay/getx/category_controller.dart';
import 'package:crafty_bay/ui/screens/all_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx/bottom_navigation_controller.dart';
import '../../widgets/all_product_category_list.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  BottomNavigationController controller = Get.put(BottomNavigationController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                controller.changeIndex(0);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: const Text(
            'Category',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<CategoryController>(
          builder: (categoryController) {
            if (categoryController.getCategoryListInProgress){
            return const Center(
              child: CircularProgressIndicator() 
            );} 
            return RefreshIndicator(
              onRefresh: () async {
                await categoryController.getCategoryList();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8.0, top: 8.0),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5/5,
                        crossAxisCount: 4),
                    itemCount: categoryController.categoryListModel.data?.length?? 0,
                    itemBuilder: (context, index) {
                      return categoriesItem(
                          categoreyItemName: categoryController.categoryListModel.data![index].categoryName?? '',
                          onTap: () {Get.to(AllProductPage(
                            categoryName: categoryController.categoryListModel.data![index].categoryName?? '',
                            categoryId: '${categoryController.categoryListModel.data![index].id?? 1}'),);},
                          image: categoryController.categoryListModel.data![index].categoryImg?? '');
                    }),
              ),
            );
            
          }
        ));
  }
}
