import 'package:flutter/material.dart';
import 'CustomSearchDelegate.dart';
import 'HomePage.dart';
import 'BidsPage.dart';
import 'AuctionHouse.dart';

int currentIndex = 0;

AppBar getAppBar(context) {
  return AppBar(
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
          ],
        ),
      ));
}

BottomNavigationBar getButtonBar(context, setState) {
  return BottomNavigationBar(
    backgroundColor: Colors.white,
    currentIndex: currentIndex,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'HOME',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.balance),
        label: 'AUCTION HOUSE',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.view_list_rounded),
        label: 'BIDS',
      ),
    ],
    onTap: (index) {
      setState(() {
        currentIndex = index;
        // navigate to the corresponding page according to the index
      });

      switch (index) {
        case 0:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
          break;

        case 1:
          {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AuctionHouse()));
          }
          break;
        case 2:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Bids()));
          }
          break;
        default:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
          break;
      }
    },
  );
}
