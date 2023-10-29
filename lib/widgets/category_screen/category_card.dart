import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/ex_category.dart';
import '../../screens/expense_screen.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          ExpenseScreen.name,
          arguments: category.title, // for expensescreen.
        );
      },
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(category.icon,
        color: const Color(0xff4F0000),
          size: 35,
        ),
      ),
      title: Text(category.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A1A1A)
        ),
      ),
      subtitle: Text('Entries: ${category.entries}',
        style: const TextStyle(
          fontSize: 16,
            color: Color(0xff4F0000)
        ),),
      trailing: Text(NumberFormat.currency(locale: 'en_IN', symbol: '₹')
          .format(category.totalAmount),
        style: const TextStyle(
          fontSize: 20,
            color: Color(0xFF303437)
        ),),
    );
  }
}
