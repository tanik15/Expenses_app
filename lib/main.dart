import 'package:expenses_app/expenses/expenses_data.dart';
import 'package:expenses_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
    await Hive.initFlutter();

  await Hive.openBox("expense_databasee");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => expenseData(),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                // '/': (context) => loginpage(),
                '/': (context) => home(),
              },
            ));
  }
}
