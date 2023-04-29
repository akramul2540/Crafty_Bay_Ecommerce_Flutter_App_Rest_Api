import 'package:flutter/material.dart';
import '../utils/utilities.dart';

class ReusableTextFormField extends StatelessWidget {
  const ReusableTextFormField({super.key, required this.hintText, required this.controller, this.maxLines, this.validator});

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines?? 1,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          alignLabelWithHint: true,
          // labelText: 'Email',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.PrimaryColor),
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.PrimaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.PrimaryColor),
          )),
    );
  }
}
