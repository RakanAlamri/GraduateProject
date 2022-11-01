import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './product_details.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsList(this.transactions);
  String _ImageURL = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(t: transactions[index]),
                ),
              ),
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(1.0),
                        child: getImage(context),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${transactions[index].ProductPrice.toStringAsFixed(2)} SAR',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        transactions[index].ProductName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        transactions[index].ProductDescription,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }

  Image getImage(context) {
    if (_ImageURL.isNotEmpty) {
      return Image.network(
        _ImageURL,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    } else {
      return const Image(image: AssetImage('assets/images/defaultimage.png'));
    }
  }
}
