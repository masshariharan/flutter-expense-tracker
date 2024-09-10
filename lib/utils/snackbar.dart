import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/utils/colors.dart';

showSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: AppColors.whiteBlue,
  ));
}
