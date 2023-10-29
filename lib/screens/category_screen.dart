import 'package:flutter/material.dart';
import '../widgets/category_screen/category_fetcher.dart';
import '../widgets/expense_form.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const name = '/category_screen'; // for routes
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Container(
          decoration:const BoxDecoration(
            color: Color(0xffEFEAE3),
          ),
          child: const CategoryFetcher()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff4F0000),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const ExpenseForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
