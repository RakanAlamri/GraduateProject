import 'package:flutter/material.dart';
import 'Product_options.dart';
import './Firebase/FirebaseAction.dart';
import './models/transaction.dart';
import 'ProfileNavigationDrawer.dart';
import 'ProductListPage.dart';

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
                icon: const Icon(Icons.search)
               ),
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

class CustomSearchDelegate extends SearchDelegate {
  // a list with all search terms (the list below is just an example list)
  // it should be the live auctions from the database
  List<String> searchTerms = [
    'car',
    'shoe',
    'watch',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () { close(context, null);}, icon: const Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

