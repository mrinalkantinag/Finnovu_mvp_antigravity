import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../screens/add_transaction_screen.dart';
import 'dashboard_screen.dart'; // Import Dashboard

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
    Provider.of<TransactionProvider>(context, listen: false).fetchTransactions();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const TransactionList();
    String activeTitle = 'Transactions';

    if (_selectedIndex == 1) {
      activePage = const DashboardScreen();
      activeTitle = 'Dashboard';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        if (provider.transactions.isEmpty) {
          return const Center(
            child: Text('No transactions added yet!'),
          );
        }
        return ListView.builder(
          itemCount: provider.transactions.length,
          itemBuilder: (context, index) {
            final tx = provider.transactions[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('\$${tx.amount.toStringAsFixed(2)}'),
                    ),
                  ),
                ),
                title: Text(
                  tx.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(tx.date),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    provider.deleteTransaction(tx.id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
