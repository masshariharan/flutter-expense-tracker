import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/utils/pref_helper.dart';
import 'package:flutter_expense_tracker/screens/add_expense_screen.dart';
import 'package:flutter_expense_tracker/utils/snackbar.dart';
import 'package:get/get.dart';
import '../model/expense_model.dart';
import '../utils/text_styles.dart';
import '../widget/expense_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];
  double totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    getExpenses();
  }

  Future<void> getExpenses() async {
    expenses = await PreferenceHelper.getExpenses();
    setState(() {
      totalExpense = expenses.fold(0.0, (sum, item) => sum + item.amount);
    });
  }

  void addExpense(Expense expense) async {
    setState(() {
      expenses.add(expense);
      totalExpense += expense.amount;
    });
    await PreferenceHelper.saveExpenses(expenses);
    showSnackBar(context: context, text: 'Expense added successfully');
  }

  void deleteExpense(int index) async {
    setState(() {
      totalExpense -= expenses[index].amount;
      expenses.removeAt(index);
    });
    await PreferenceHelper.saveExpenses(expenses);
    showSnackBar(context: context, text: 'Expense deleted successfully');
  }

  void updateExpense(Expense expense, int index) async {
    setState(() {
      totalExpense -= expenses[index].amount;
      expenses[index] = expense;
      totalExpense += expense.amount;
    });
    await PreferenceHelper.saveExpenses(expenses);
    showSnackBar(context: context, text: 'Expense updated successfully');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Expense Tracker',
            style: titleTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text('Summary', style: headingTextStyle),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 0.4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                    'Total Expenses: \$${totalExpense.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: boldTextStyle),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Expenses', style: headingTextStyle),
              const SizedBox(
                height: 5,
              ),
              expenses.isEmpty
                  ? Expanded(
                      child: Center(
                          child: Text(
                      'No item is added!',
                      style: expensesTextStyle.copyWith(
                          fontWeight: FontWeight.w400),
                    )))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          return ExpenseListItem(
                            expense: expenses[index],
                            onedit: () async {
                              final updatedExpense = await Get.to(
                                  AddExpenseScreen(expense: expenses[index]),
                                  transition: Transition.rightToLeft);
                              if (updatedExpense != null) {
                                updateExpense(updatedExpense, index);
                              }
                            },
                            onDelete: () => deleteExpense(index),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            final newExpense = await Get.to(const AddExpenseScreen(),
                transition: Transition.rightToLeft);
            if (newExpense != null) {
              addExpense(newExpense);
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
