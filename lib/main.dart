
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; 
// import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Removed
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // Removed

import 'providers/transaction_provider.dart';
import 'screens/home_screen.dart';
import 'database/db_helper.dart'; // Import the helper

void main() {
  // Delegate initialization to the platform-specific helper
  DBHelper.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: MaterialApp(
        title: 'Finnovu MVP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 2,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
