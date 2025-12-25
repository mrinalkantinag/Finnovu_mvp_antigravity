
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../database/db_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  // Fetch transactions from DB
  Future<void> fetchTransactions() async {
    _transactions = await DBHelper.getTransactions();
    notifyListeners();
  }

  // Add transaction
  Future<void> addTransaction(String title, double amount, DateTime date, Category category) async {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    
    await DBHelper.insertTransaction(newTransaction);
    await fetchTransactions(); // Reload from DB to ensure consistency
  }

  // Delete transaction
  Future<void> deleteTransaction(String id) async {
    await DBHelper.deleteTransaction(id);
    await fetchTransactions();
  }

  // Calculate total expenses
  double get totalExpenses {
    return _transactions.fold(0.0, (sum, item) => sum + item.amount);
  }

  // Calculate expenses by category
  Map<Category, double> get expensesByCategory {
    Map<Category, double> data = {};
    for (var tx in _transactions) {
      if (data.containsKey(tx.category)) {
        data[tx.category] = data[tx.category]! + tx.amount;
      } else {
        data[tx.category] = tx.amount;
      }
    }
    return data;
  }
}
