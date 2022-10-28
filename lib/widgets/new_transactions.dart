import 'package:flutter/foundation.dart';
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

  final DescriptionController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);
    final enteredDescrition = DescriptionController.text;
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
      'ProductDescription': DescriptionController.text,
    });

    //Navigator.of(context).pop();
  }

  File? _image;
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
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              decoration: const InputDecoration(labelText: 'Product Description'),
              // onChanged: (val) => amountString = val,
              controller: DescriptionController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            const SizedBox(
              height: 20,
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
                        : const Text("There is no image!")

                // child: webImage == null
                //     ? _image != null
                //         ? Image.file(
                //             _image!,
                //             width: 100,
                //             height: 100,
                //             fit: BoxFit.cover,
                //           )
                //         : Text("There is no image!")
                //     : Image.memory(
                //         webImage,
                //         width: 100,
                //         height: 100,
                //         fit: BoxFit.cover,
                //       ),
                // Image.network(
                // 'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=1200',
                // width: 100,
                // height: 100,
                // fit: BoxFit.cover,
                // ),
                ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                  color: Colors.lightBlueAccent,
                  minWidth: 120,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: submitData,
                  child: const Text('Add Transaction')),
            ),
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
        children: [Icon(icon), const SizedBox(width: 20), Text(title)],
      ),
    ),
  );
}
