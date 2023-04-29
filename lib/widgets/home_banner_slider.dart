import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/model/product_slider_model.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';

class BannerSlider extends StatelessWidget {
  BannerSlider({Key? key, required this.productSliderModel,}) : super(key: key);

  final CarouselController _carouselController = CarouselController();
  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final ProductSliderModel productSliderModel;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            autoPlay: true,
              onPageChanged: (index, _) {
                _currentSelectedIndex.value = index;
              },
              viewportFraction: 1,
              height: 150.0),
          items: productSliderModel.data?.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColor.PrimaryColor),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          slider.image?? '',
                          height: 120,
                          width: 160,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(slider.title?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: Text(
                                    'Buy Now',
                                    style:
                                        TextStyle(color: AppColor.PrimaryColor),
                                  )),
                            )
                          ],
                        )
                      ],
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8.0),
        ValueListenableBuilder(
          valueListenable: _currentSelectedIndex,
          builder: (BuildContext context, updatedValue, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i <(productSliderModel.data?.length?? 0); i++)
                  Container(
                    margin: const EdgeInsets.all(2),
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: i == _currentSelectedIndex.value
                            ? AppColor.PrimaryColor
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                  )
              ],
            );
          },
        ),
      ],
    );
  }
}
