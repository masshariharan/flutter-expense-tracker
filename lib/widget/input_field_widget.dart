import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ReusableInputField extends StatelessWidget {
  const ReusableInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.inputType,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteBlue,
        labelText: labelText,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
