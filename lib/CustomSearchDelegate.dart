import 'package:flutter/material.dart';
import './Firebase/FirebaseAction.dart';

class CustomSearchDelegate extends SearchDelegate<Future<Widget>> {
  // a list with all search terms (the list below is just an example list)
  // it should be the live auctions from the database

  List<String> searchKeys = [];

  Future<List<String>> searchFirebase() async {
    searchKeys.clear();
    List<String> searchValue = [];
    var name = query.toLowerCase();
    if (name.isEmpty) {
      return [];
    }

    final snapshot = await searchProduct(name);

    for (var element in snapshot) {
      var value = element.split(';xxx;')[0];
      var key = element.split(';xxx;')[1];
      searchKeys.add(key);
      searchValue.add(value);
    }
    return searchValue;
  }

  void searchTab(index) {
    var key = searchKeys[index];
    // from here you can pass it to product details
  }

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
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildList();
  }

  Widget buildList() {
    return FutureBuilder(
      future: searchFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              var result = snapshot.data?[index];
              result ??= "";
              return ListTile(
                title: Text(result),
                onTap: () {
                  searchTab(index);
                },
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
