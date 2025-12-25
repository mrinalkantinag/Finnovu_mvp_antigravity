
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work, other }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Transaction({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = id ?? uuid.v4();

  // Convert a Transaction into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name, // Store enum as string
    };
  }

  // Extract a Transaction object from a Map object
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: Category.values.byName(map['category']),
    );
  }
}
