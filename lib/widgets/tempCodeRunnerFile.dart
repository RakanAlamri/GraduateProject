import 'package:flutter/material.dart';
import '../Firebase/FirebaseAction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

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

    //Navigator.of(context).pop();
  }

  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    //final imageTemprorary = File(image.path);
    final imagePermanent = await saveFilePermanently(image.path);
    setState(() {
      this._image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
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
            SizedBox(
              height: 20,
            ),
            CustomButton(
                title: 'Pick from Gallery',
                icon: Icons.image_search_outlined,
                onClick: getImage),
            SizedBox(
              height: 20,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=1200',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 176, 39, 39),
                ),
                child: Text('Add Transaction'),
                onPressed: submitData),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    color: Colors.blueAccent,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [Icon(icon), SizedBox(width: 20), Text(title)],
      ),
    ),
  );
}
