import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../Firebase/FirebaseAction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/foundation.dart';

class NewTrtansactions extends StatefulWidget {
  final Function addNewTransaction;
  NewTrtansactions(this.addNewTransaction);

  @override
  State<NewTrtansactions> createState() => _NewTrtansactionsState();
}

class _NewTrtansactionsState extends State<NewTrtansactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final DescriptionController = TextEditingController();
  var pid;
  File? _image;

  void submitData() {
    final enteredTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);
    final enteredDescrition = DescriptionController.text;

    if (enteredTitle.isEmpty || enterdAmount <= 0) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    final expired_date = DateTime.now().add(const Duration(days: 3));
    pid = const Uuid().v4();

    final data = {
      'ProductName': titleController.text,
      'ProductPrice': enterdAmount,
      'ProductDescription': enteredDescrition,
      'Owner': user?.uid,
      'Status': true,
      'Category': 'item',
      'ExpiredDate': expired_date.millisecondsSinceEpoch,
      'ts': DateTime.now().millisecondsSinceEpoch
    };

    print('111111');

    widget.addNewTransaction(
      titleController.text,
      data,
    );

    print('2222222222');
    AddProduct(pid, data);
    if (_image != null) {
      uploadImageProduct(pid, _image!);
    }
    print('3333333');

    Navigator.of(context).pop();
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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText:'Product Name',),
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty){
                        return "Enter Product Name";
                      }else{
                        submitData();
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText:'Starting Price',),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty){
                        return "Enter Starting Price";
                      }else{
                        submitData();
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText:'Product Description',),
                    controller: DescriptionController,
                    validator: (value) {
                      if (value!.isEmpty){
                        return "Enter Product Description";
                      }else{
                        submitData();
                      }
                    },
                    
                  ),
                  // TextField(
                  //   decoration: const InputDecoration(labelText: 'Product Name'),
                  //   // onChanged: (val) => titleInput = val,
                  //   controller: titleController,
                  //   onSubmitted: (_) => submitData(),
                  // ),
                  // TextField(
                  //   decoration: const InputDecoration(labelText: 'Product Price'),
                  //   // onChanged: (val) => amountString = val,
                  //   controller: amountController,
                  //   keyboardType: TextInputType.number,
                  //   onSubmitted: (_) => submitData(),
                  // ),
                  // TextField(
                  //   decoration:
                  //       const InputDecoration(labelText: 'Product Description'),
                  //   // onChanged: (val) => amountString = val,
                  //   controller: DescriptionController,
                  //   onSubmitted: (_) => submitData(),
                  // ),
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
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                final snackBar = SnackBar(content: Text('Submitted'),);
                                submitData();
                              }
                            },
                            child: const Text('Add Transaction')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
