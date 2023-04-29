import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/model/create_wishlist_model.dart';
import 'package:crafty_bay/ui/screens/cart_screen.dart';
import 'package:crafty_bay/ui/screens/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../getx/cart_controller.dart';
import '../../getx/product_details_controller.dart';
import '../../getx/user_data_controller.dart';
import '../../getx/wish_list_controller.dart';
import '../../utils/utilities.dart';
import '../../widgets/increment_decrement.dart';
import '../../widgets/product_details_Slieder.dart';
import 'bottom_nav_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CarouselController _carouselController = CarouselController();
  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  final UserDataController userDataController = Get.put(UserDataController());
  final CartController cartController = Get.put(CartController());
  final WishListController wishListController = Get.put(WishListController());

  Color? selectedColor;
  String? selectedSize;
  double totalAmount = 0.0;
  int currentValue = 1;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productDetailsController.getProductsDetailsById(widget.productId);
      wishListController.createProductWishList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.2),
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
            'Product Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<ProductDetailsController>(
            builder: (productDetailsController) {
          if (productDetailsController.productDetailsInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final List<Color> AvailableColors = getColorsFromString(
                productDetailsController
                        .productDetailsModel.data!.first.color ??
                    '');
            final List<String> AvailableSizes = getSizesFromString(
                productDetailsController.productDetailsModel.data!.first.size ??
                    '');
            if (totalAmount == 0) {
              totalAmount = double.tryParse(productDetailsController
                          .productDetailsModel.data!.first.product?.price ??
                      '') ??
                  0.0;
              0;
            }
            // final Data productDetailsData = productDetailsController.productDetailsModel.data!.first;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductDetailsSlider(sliders: [
                          productDetailsController
                                  .productDetailsModel.data!.first.img1 ??
                              '',
                          productDetailsController
                                  .productDetailsModel.data!.first.img2 ??
                              '',
                          productDetailsController
                                  .productDetailsModel.data!.first.img3 ??
                              '',
                          productDetailsController
                                  .productDetailsModel.data!.first.img4 ??
                              ''
                        ]),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productDetailsController
                                                .productDetailsModel
                                                .data!
                                                .first
                                                .product
                                                ?.title ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text(
                                        "Save 30%",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IncrementDecrement(
                                    onChange: (oldValue, newValue) {
                                      totalAmount = (double.tryParse(
                                                  productDetailsController
                                                          .productDetailsModel
                                                          .data!
                                                          .first
                                                          .product
                                                          ?.price ??
                                                      '0') ??
                                              0.0) *
                                          newValue;
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    IconlyLight.star,
                                    color: Color(0xffFFD700),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    (productDetailsController
                                                .productDetailsModel
                                                .data!
                                                .first
                                                .product
                                                ?.star ??
                                            0.0)
                                        .toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 8.0),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(ReviewPage(productId: productDetailsController
                                                .productDetailsModel
                                                .data!
                                                .first.productId?? 0));
                                    },
                                    child: Text(
                                      'Reviews',
                                      style: TextStyle(
                                          color: AppColor.PrimaryColor),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  GetBuilder<WishListController>(
                                    builder: (wishListController) {
                                      return InkWell(
                                          onTap: (){
                                           wishListController.createProductWishList(widget.productId).then((result){
                                            if (result){
                                              Get.snackbar('Success!',
                                            "added to wishlist",
                                            backgroundColor: Colors.greenAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                            } else {
                                              Get.snackbar('Error!',
                                            "add to wishlist failed!",
                                            backgroundColor: Colors.redAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                            }
                                           });
                                          },
                                          child: Container(
                                              height: 22,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: AppColor.PrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Icon(
                                                IconlyLight.heart,
                                                size: 14,
                                                color: Colors.white,
                                              )));
                                    }
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Color',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  for (int i = 0;
                                      i < AvailableColors.length;
                                      i++)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          selectedColor = AvailableColors[i];
                                          setState(() {});
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: AvailableColors[i],
                                          radius: 14,
                                          child: selectedColor ==
                                                  AvailableColors[i]
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 18,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Size',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  for (int i = 0;
                                      i < AvailableSizes.length;
                                      i++)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selectedSize = AvailableSizes[i];
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 28,
                                            width: 28,
                                            decoration: BoxDecoration(
                                              color: selectedSize ==
                                                      AvailableSizes[i]
                                                  ? Colors.blueGrey
                                                      .withOpacity(0.3)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.blueGrey),
                                            ),
                                            child: Center(
                                                child: Text(
                                              AvailableSizes[i],
                                              style: const TextStyle(
                                                  fontSize: 8.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                productDetailsController
                                        .productDetailsModel.data!.first.des ??
                                    '',
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColor.PrimaryColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0))),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '\$$totalAmount',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColor.PrimaryColor),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                          width: 110,
                          child: GetBuilder<CartController>(
                              builder: (cartController){
                            if (cartController.addToCartInProgress) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.PrimaryColor),
                                onPressed: () async {
                                  final bool _authState =
                                      userDataController.checkAuthState();
                                  if (_authState &&
                                      selectedColor != null &&
                                      selectedSize != null) {
                                    final result =
                                        await cartController.addtoCart(
                                            widget.productId,
                                            selectedColor.toString(),
                                            selectedSize ?? '');
                                    if (result) {
                                      if (mounted) {
                                        Get.snackbar(
                                            'Success!', "Product add to cart successfully!",
                                            mainButton: TextButton(onPressed: (){Get.off(const CartPage());}, child: Text('Go to cart', style: TextStyle(color: AppColor.PrimaryColor, fontWeight: FontWeight.w500),)),
                                            backgroundColor: Colors.greenAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                      }
                                    } else {
                                      if (mounted) {
                                        Get.snackbar('Error!',
                                            "Add to cart failed! Try Again",
                                            backgroundColor: Colors.redAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                      }
                                    }
                                  }
                                            if (selectedColor ==null&& selectedSize ==null){
                                            Get.snackbar('Error!',
                                            "Select your desired size and color first!",
                                            backgroundColor: Colors.redAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                            }
                                            if (selectedColor ==null && selectedSize !=null){
                                              Get.snackbar('Error!',
                                            "Select your desired color first!",
                                            backgroundColor: Colors.redAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                            }
                                            if (selectedColor !=null && selectedSize ==null){
                                              Get.snackbar('Error!',
                                            "Select your desired size first!",
                                            backgroundColor: Colors.redAccent,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(8.0));
                                            }
                                },
                                child: const Text(
                                  'Add to cart',
                                  style: TextStyle(color: Colors.white),
                                ));
                            
                          }))
                    ],
                  ),
                )
              ],
            );
          }
        }));
  }
}

List<String> getSizesFromString(String sizes) {
  return sizes.split(',');
}

List<Color> getColorsFromString(String color) {
  List<Color> hexColor = [];
  final List<String> allColors = color.split(',');
  for (var element in allColors) {
    hexColor.add(HexColor(element));
  }
  return hexColor;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
