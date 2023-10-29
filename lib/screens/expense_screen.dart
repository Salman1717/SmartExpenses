import 'package:flutter/material.dart';
import '../widgets/expense_screen/expense_fetcher.dart';
import 'category_screen.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  static const name = '/expense_screen';

  @override
  Widget build(BuildContext context) {
    // get the argument passed from category_card.
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
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
        shadowColor: Colors.black87,
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              category,
              style: const TextStyle(
                  color: Color(0xFF0c2431),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        backgroundColor: const Color(0xFFe1dad2),
        elevation: 0.8,
      ),
      body: ExpenseFetcher(category),
    );
  }
}
