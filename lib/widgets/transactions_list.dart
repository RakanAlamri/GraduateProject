import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    '\$${transactions[index].ProductPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: <Widget>[
                //     Text(
                //       transactions[index].ProductDescription,
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 17,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}