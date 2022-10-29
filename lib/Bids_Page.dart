import 'package:final_project/Auction_House.dart';
import 'package:flutter/material.dart';
import 'package:final_project/ProfileNavigationDrawer.dart';

import 'HomePage.dart';

class Bids extends StatefulWidget {
  const Bids({super.key});

  @override
  State<Bids> createState() => _BidsState();
}

class _BidsState extends State<Bids> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
          title: const Text(
            'ZAWD',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Bellota',
              fontSize: 30,
            ),
          ),
        ),
        drawerScrimColor: Colors.black38,
        drawer: const ProfileNavigationDrawer(),
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
              if (_currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => Home()),
                  ),
                );

                //Navigator.pop(context);
              }
              if (_currentIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => AuctionHouse()),
                  ),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
