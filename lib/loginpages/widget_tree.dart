
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/database_provider.dart';
import '../screens/all_expenses.dart';
import '../screens/category_screen.dart';
import '../screens/expense_screen.dart';
import 'HomePage.dart';
import 'Login_register.dart';
import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(stream: Auth().authStateChanges, builder: (context, snapshot){
      if(snapshot.hasData){
        return ChangeNotifierProvider(
          create: (_) => DatabaseProvider(),
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: CategoryScreen.name,
          routes: {
            CategoryScreen.name: (_) => const CategoryScreen(),
            ExpenseScreen.name: (_) => const ExpenseScreen(),
            AllExpenses.name: (_) => const AllExpenses(),
          },
        ));
      }else{
        return const LoginPage();
      }
    });
  }
}
