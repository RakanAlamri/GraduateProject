import 'package:flutter/material.dart';
import 'Product_options.dart';
import './Firebase/FirebaseAction.dart';
import './models/transaction.dart';
import 'ProfileNavigationDrawer.dart';
import 'ProductListPage.dart';
import 'CustomSearchDelegate.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            actions: [
              // this is the search button
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: const Icon(Icons.search)),
            ],
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
                  // Icon(
                  //   Icons.notifications_none_outlined,
                  //   color: Colors.white,
                  // )
                ],
              ),
            )),
        drawerScrimColor: Colors.black38,
        drawer: const ProfileNavigationDrawer(),
        body: ProductListPage(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          items: const [
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
              // navigate to the corresponding page according to the index
            });
          },
        ),
      ),
    );
  }
}
