import 'dart:io';
import 'package:final_project/models/transaction.dart';
import 'package:flutter/material.dart';
import '../Firebase/FirebaseAction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/foundation.dart';

class EditProudct extends StatefulWidget {
  final Function callbackEdit;
  final Transaction transaction;
  EditProudct(this.callbackEdit, this.transaction);

  @override
  State<EditProudct> createState() => _NewTrtansactionsState();
}

class _NewTrtansactionsState extends State<EditProudct> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final DescriptionController = TextEditingController();
  File? _image;

  void submitData() {
    final enteredTitle = titleController.text;
    final enterdAmount = amountController.text;
    final enteredDescrition = DescriptionController.text;
    final data = {
      'ProductName': (enteredTitle.isEmpty)
          ? widget.transaction.ProductName
          : enteredTitle,
      'ProductPrice': (enterdAmount.isEmpty)
          ? widget.transaction.ProductPrice
          : double.parse(enterdAmount),
      'ProductDescription': (enteredDescrition.isEmpty)
          ? widget.transaction.ProductDescription
          : enteredDescrition,
      'Owner': widget.transaction.owner,
      'Status': true,
      'Category': 'item',
      'ExpiredDate': widget.transaction.ExpiredDate,
      'ts': DateTime.now().millisecondsSinceEpoch
    };
    ChangeProductsDetails(widget.transaction.id, data);
    if (_image != null) {
      uploadImageProduct(widget.transaction.id, _image!);
    }
    Navigator.of(context).pop();
    data['URL'] = widget.transaction.URL;
    widget.callbackEdit(widget.transaction.id, data);
  }

  Uint8List webImage = Uint8List(8);
  Future getImage() async {
    if (!kIsWeb) {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      //final imageTemprorary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);
      setState(() {
        this._image = imagePermanent;
      });
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      //final imageTemprorary = File(image.path);
      //final imagePermanent = await saveFilePermanently(image.path);
      var f = await image.readAsBytes();
      setState(() {
        this.webImage = f;
        _image = File('a');
      });
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  String? selectedItem;
  List<String> items = [
    "Car",
    "Clothing",
    "Shoes",
    "Book",
    "Electronics",
    "Furniture",
    "Accessories"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                // onChanged: (val) => titleInput = val,
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Product Price'),
                // onChanged: (val) => amountString = val,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Product Description'),
                // onChanged: (val) => amountString = val,
                controller: DescriptionController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Center(
                child: DropdownButton<String>(
                  hint: const Text("Select The Category"),
                  value: selectedItem,
                  onChanged: (newValue) {
                    setState(() {
                      selectedItem = newValue;
                    });
                  },
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                    title: 'Pick from Gallery',
                    icon: Icons.image_search_outlined,
                    onClick: getImage),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: kIsWeb
                          ? webImage != null
                              ? Image.memory(
                                  webImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : const Text("There is no image!")
                          : _image != null
                              ? Image.file(
                                  _image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : const Text("There is no image!")),
                  Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                        color: Colors.lightBlueAccent,
                        minWidth: 120,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: submitData,
                        child: const Text('Edit Transaction')),
                  ),
                ],
              ),
            ],
          ),
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
        children: [Icon(icon), const SizedBox(width: 20), Text(title)],
      ),
    ),
  );
}
