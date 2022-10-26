import './models/transaction.dart';
import './widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transactions_list.dart';
import './Firebase/FirebaseAction.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Transaction> _userTransactions = [];
  // Check if firebase_auth uid corresponds to document in db.
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    var dataSnapshot = await getAllProduct();

    dataSnapshot.forEach((key, value) {
      print(value);
      _addNewTransaction(
          value['ProductName'], double.parse(value['ProductPrice']));
    });
  }

  void _addNewTransaction(String title, double amount) {
    final newT = Transaction(
        id: DateTime.now().toString(),
        ProductName: title,
        ProductPrice: amount,
        ProductDescription: "",
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newT);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTrtansactions(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TransactionsList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
