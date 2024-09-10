import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/utils/snackbar.dart';
import 'package:flutter_expense_tracker/utils/text_styles.dart';
import 'package:flutter_expense_tracker/widget/input_field_widget.dart';
import 'package:get/get.dart';

import '../model/expense_model.dart';
import '../utils/colors.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, this.expense});
  final Expense? expense;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void saveExpense() {
    final double? amount = double.tryParse(amountController.text);
    final String description = descriptionController.text;

    if (amount != null && description.isNotEmpty) {
      final expense = Expense(amount: amount, description: description);
      Get.back(result: expense);
    } else {
      showSnackBar(context: context, text: 'Please enter valid data');
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      amountController.text = widget.expense!.amount.toString();
      descriptionController.text = widget.expense!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.expense == null ? 'Add Expense' : 'Update Expense',
            style: titleTextStyle.copyWith(color: AppColors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ReusableInputField(
                controller: amountController,
                inputType: TextInputType.number,
                labelText: 'Amount',
              ),
              const SizedBox(height: 25),
              ReusableInputField(
                controller: descriptionController,
                inputType: TextInputType.name,
                labelText: 'Description',
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(colors: [
                      AppColors.lightBlue,
                      AppColors.blue,
                    ])),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: saveExpense,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      widget.expense == null ? 'Save' : 'Update',
                      style:
                          const TextStyle(color: AppColors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
