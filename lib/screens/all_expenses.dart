import 'package:flutter/material.dart';
import '../widgets/all_expenses_screen/all_expenses_fetcher.dart';
import 'category_screen.dart';

class AllExpenses extends StatefulWidget {
  const AllExpenses({super.key});

  static const name = '/all_expenses';

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEAE3),
      appBar: AppBar(
          leading:InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryScreen()),
                );
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('All Expenses', style: TextStyle(
            color:Color(0xff4F0000) ,
          ),)),
      body: const AllExpensesFetcher(),
    );
  }
}
