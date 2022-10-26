import 'package:final_project/HomePage.dart';
import 'package:final_project/Modify.dart';
import 'package:final_project/ProfileNavigationDrawer.dart';
import 'package:flutter/material.dart';

class Product_options extends StatefulWidget {
  @override
  State<Product_options> createState() => _Product_optionsState();
}

class _Product_optionsState extends State<Product_options> {
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: Padding(
                padding: const EdgeInsets.only(left: 77),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
              )),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Modify()),
                      );
                    },
                    child: Text(
                      'Add new auction',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    minWidth: 250,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      //navigate to modify page
                    },
                    child: Text(
                      'Modify auction',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    minWidth: 250,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      //show deletion message
                    },
                    child: Text(
                      'Delete auction',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    minWidth: 250,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ],
            ),
          ),
          drawerScrimColor: Colors.black38,
          drawer: const ProfileNavigationDrawer(),
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
                if (_currentIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
