import 'package:flutter/material.dart';

import '../utils/utilities.dart';

class IncrementDecrement extends StatefulWidget {
  const IncrementDecrement({super.key, required this.onChange});

  final Function(int, int) onChange;

  @override
  State<IncrementDecrement> createState() => _IncrementDecrementState();
}

class _IncrementDecrementState extends State<IncrementDecrement> {
  final TextEditingController controller = TextEditingController();

  int currentValue = 1;
  int previousValue = 1;
  @override
  void initState() {
    super.initState();
    controller.text = currentValue.toString();
    controller.addListener(() {
      widget.onChange(previousValue, currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
              if (currentValue != previousValue){
              previousValue = currentValue;
            }
            currentValue++;
            controller.text = currentValue.toString();
          },
          child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: AppColor.PrimaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: const Icon(Icons.add, color: Colors.white, size: 12)),
        ),
        SizedBox(
            width: 45,
            child: TextFormField(
              controller: controller,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            )),
        InkWell(
          onTap: () {
            if (currentValue != previousValue){
              previousValue = currentValue;
            }
            if (currentValue > 1) {
              currentValue--;
              controller.text = currentValue.toString();
            }
          },
          child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: AppColor.PrimaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 12,
              )),
        ),
      ],
    );
  }
}
