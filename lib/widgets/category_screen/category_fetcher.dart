import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../loginpages/auth.dart';
import '../../models/database_provider.dart';
import './total_chart.dart';
import './category_list.dart';
import '../../screens/all_expenses.dart';

class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {
  late Future _categoryList;

  Future _getCategoryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchCategories();
  }

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userid() {
    return Text(
      'Signed In as ${user?.email ?? 'User email'}',
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(
        0xFFFF2424,
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    // fetch the list and set it to _categoryList
    _categoryList = _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoryList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // if connection is done then check for errors or return the result
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 250.0,
                    child: TotalChart(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expenses',
                        style: TextStyle(
                          color: Color(0xff1A1A1A),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AllExpenses.name);
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: CategoryList()),
                  _userid(),
                  SizedBox(
                    height: 8,
                  ),
                  _signOutButton()
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
