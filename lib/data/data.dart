import 'dart:math';

// import 'package:flutter_budget_ui/models/category_model.dart';
import '../models/category_model.dart';
// import 'package:flutter_budget_ui/models/expense_model.dart';
import '../models/expense_model.dart';

final rand = Random();

final List<double> weeklySpending = [
  // rand.nextDouble() * 100,
  // rand.nextDouble() * 100,
  // rand.nextDouble() * 100,
  // rand.nextDouble() * 100,
  // rand.nextDouble() * 100,
  // rand.nextDouble() * 100,
  // rand.nextDouble() * 100,
  30.0,
  10.0,
  50.0,
  20.0,
  10.0,
  70.0,
  40.0,
];

_generateExpenses() {
  List<Expense> expenses = [
    Expense(name: 'Item 0', cost: rand.nextDouble() * 90),
    Expense(name: 'Item 1', cost: rand.nextDouble() * 90),
    Expense(name: 'Item 2', cost: rand.nextDouble() * 90),
    Expense(name: 'Item 3', cost: rand.nextDouble() * 90),
    Expense(name: 'Item 4', cost: rand.nextDouble() * 90),
    Expense(name: 'Item 5', cost: rand.nextDouble() * 90),
  ];
  return expenses;
}

List<Category> categories = [
  Category(name: 'Groceries', maxAmount: 450, expenses: _generateExpenses()),
  Category(name: 'Clothing', maxAmount: 500, expenses: _generateExpenses()),
  Category(name: 'Electronics', maxAmount: 600, expenses: _generateExpenses()),
  Category(name: 'Cosmetics', maxAmount: 330, expenses: _generateExpenses()),
  Category(name: 'Fruit & Veg', maxAmount: 500, expenses: _generateExpenses()),
  Category(name: 'Restuarants', maxAmount: 1000, expenses: _generateExpenses()),
];
