
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        if (provider.transactions.isEmpty) {
          return const Center(child: Text('No data to display'));
        }

        final categoryData = provider.expensesByCategory;
        final total = provider.totalExpenses;

        return Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Total Expenses', style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    sections: categoryData.entries.map((entry) {
                      final category = entry.key;
                      final amount = entry.value;
                      final percentage = (amount / total) * 100;

                      return PieChartSectionData(
                        color: _getCategoryColor(category),
                        value: amount,
                        title: '${percentage.toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            // Legend
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: categoryData.keys.map((category) {
                return Chip(
                  avatar: CircleAvatar(backgroundColor: _getCategoryColor(category)),
                  label: Text(category.name.toUpperCase()),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.food:
        return Colors.orange;
      case Category.travel:
        return Colors.blue;
      case Category.leisure:
        return Colors.purple;
      case Category.work:
        return Colors.green;
      case Category.other:
        return Colors.grey;
    }
  }
}
