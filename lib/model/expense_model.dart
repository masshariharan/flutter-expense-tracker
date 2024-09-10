class Expense {
  double amount;
  String description;

  Expense({required this.amount, required this.description});

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'description': description,
      };

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      amount: json['amount'],
      description: json['description'],
    );
  }
}
