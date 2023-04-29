import 'package:flutter/material.dart';
import '../utils/utilities.dart';

class categoriesItem extends StatelessWidget {
  const categoriesItem({
    super.key,
    required this.categoreyItemName,
    required this.onTap,
    required this.image,
  });

  final String categoreyItemName;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 8.0),
      child: Column(
        children: [
          Flexible(
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.PrimaryColor.withOpacity(0.2)),
                child: Image(image: NetworkImage(image), height: 35,width: 35,)
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            categoreyItemName,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColor.PrimaryColor),
          )
        ],
      ),
    );
  }
}
