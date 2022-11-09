import './models/transaction.dart';
import './widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transactions_list.dart';
import './Firebase/FirebaseAction.dart';

class ProductListPage extends StatefulWidget {
  String type;
  ProductListPage(this.type, {super.key});
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
    Map<dynamic, dynamic> dataSnapshot;
    if (widget.type == "home") {
      dataSnapshot = await getAllProduct();
    } else if (widget.type == 'bids') {
      dataSnapshot = await getUserBids();
    } else {
      dataSnapshot = await getProductForUser();
    }
    if (dataSnapshot.isEmpty) {
      print('${widget.type} has no records ');
      return;
    }

    dataSnapshot.forEach((key, value) async {
      String image = await getImageProduct(key);
      final highestPrice = await getBids(key);
      if (image.isEmpty) image = '';
      value['URL'] = image;
      value['HighestPrice'] = highestPrice.value;
      _addNewTransaction(key, value);
    });
  }

  void _addNewTransaction(String id, final data) {
    var price = data['ProductPrice'];
    if (data['HighestPrice'] != "") {
      price = data['HighestPrice'];
    }

    price ??= data['ProductPrice'];

    price = double.tryParse(price.toString());

    final newT = Transaction((data['URL'] == null) ? "" : data['URL'],
        id: id,
        ProductName: data['ProductName'],
        ProductPrice: price,
        ProductDescription: data['ProductDescription'],
        date: data['ts'],
        owner: data['Owner'],
        ExpiredDate: data['ExpiredDate']);

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
