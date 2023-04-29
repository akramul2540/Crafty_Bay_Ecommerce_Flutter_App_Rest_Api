import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';

class ProductDetailsSlider extends StatelessWidget {
  ProductDetailsSlider({Key? key, required this.sliders}) : super(key: key);

  final List<String> sliders;

  final CarouselController _carouselController = CarouselController();
  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
              onPageChanged: (index, _) {
                _currentSelectedIndex.value = index;
              },
              viewportFraction: 1,
              height: 170.0),
          items: sliders.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(slider), fit: BoxFit.scaleDown),
                        color: Colors.grey.withOpacity(0.2)),
                    alignment: Alignment.center,);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8.0),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ValueListenableBuilder(
                  valueListenable: _currentSelectedIndex,
                  builder: (BuildContext context, updatedValue, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < sliders.length; i++)
                          Container(
                            margin: const EdgeInsets.all(2),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                color: i == _currentSelectedIndex.value
                                    ? AppColor.PrimaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),),
                          )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

