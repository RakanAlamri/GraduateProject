import 'package:final_project/HomePage.dart';
import 'package:final_project/ProfileNavigationDrawer.dart';
import 'package:flutter/material.dart';
import './Firebase/FirebaseAction.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Modify extends StatefulWidget {
  @override
  State<Modify> createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  final PNameController = TextEditingController();
  final PPriceController = TextEditingController();
  final PBPDController = TextEditingController();

  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ZAWD',
                  style: TextStyle(
                    fontFamily: 'Bellota',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        drawerScrimColor: Colors.black38,
        drawer: const ProfileNavigationDrawer(),
        body: Column(
          children: [
            Form(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: PNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          hintText: 'Pname',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: PPriceController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Starting Price',
                          hintText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: PBPDController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Brief Product Description',
                          hintText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Here goes the photo thing

            MaterialButton(
              onPressed: () {
                AddProduct({
                  'ProductName': PNameController.text,
                  'ProductPrice': PPriceController.text,
                  'ProductDescription': PBPDController.text
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );

                Fluttertoast.showToast(
                    msg: "Product Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              color: Colors.lightBlueAccent,
              minWidth: 120,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'AUCTION HOUSE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'BIDS',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            });
          },
        ),
      ),
    );
  }
}
