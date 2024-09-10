import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/expense_model.dart';

class PreferenceHelper {
  static const String expense = 'expenses';

  static Future<List<Expense>> getExpenses() async {
    List<Expense> expenses = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedExpenses = prefs.getStringList(expense);
    if (storedExpenses != null) {
      expenses =
          storedExpenses.map((e) => Expense.fromJson(json.decode(e))).toList();
    }
    return expenses;
  }

  static Future<void> saveExpenses(List<Expense> expenses) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> expenseJsonList =
        expenses.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(expense, expenseJsonList);
  }

  static Future<void> clearExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(expense);
  }
}
