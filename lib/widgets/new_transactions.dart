import 'package:flutter/material.dart';
import '../Firebase/FirebaseAction.dart';

class NewTrtansactions extends StatefulWidget {
  final Function addNewTransaction;
  NewTrtansactions(this.addNewTransaction);

  @override
  State<NewTrtansactions> createState() => _NewTrtansactionsState();
}

class _NewTrtansactionsState extends State<NewTrtansactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enterdAmount <= 0) {
      return;
    }
    widget.addNewTransaction(
      titleController.text,
      double.parse(amountController.text),
    );
    AddProduct({
      'ProductName': titleController.text,
      'ProductPrice': amountController.text,
      'ProductDescription': ''
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
              // onChanged: (val) => titleInput = val,
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product Price'),
              // onChanged: (val) => amountString = val,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                ),
                child: Text('Add Transaction'),
                onPressed: submitData),
          ],
        ),
      ),
    );
  }
}