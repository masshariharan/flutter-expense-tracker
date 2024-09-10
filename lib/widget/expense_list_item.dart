import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/utils/colors.dart';
import 'package:flutter_expense_tracker/utils/text_styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/expense_model.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;
  final VoidCallback onedit;

  const ExpenseListItem(
      {super.key,
      required this.expense,
      required this.onDelete,
      required this.onedit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  onedit();
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: AppColors.white,
                icon: Icons.edit,
                flex: 2,
              ),
              SlidableAction(
                onPressed: (context) {
                  onDelete();
                },
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                icon: Icons.delete,
                flex: 2,
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            title: Text(
              expense.description,
              style: expensesTextStyle,
            ),
            trailing: Text('\$${expense.amount.toStringAsFixed(2)}',
                style: expensesTextStyle),
          ),
        ),
        Container(
          color: Colors.grey,
          height: 0.3,
        )
      ],
    );
  }
}
