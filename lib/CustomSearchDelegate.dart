import 'package:final_project/models/transaction.dart';
import 'package:final_project/widgets/product_details.dart';
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
      var splited = element.split(';xxx;');

      var value = splited[0];
      var key = splited[1];
      var price = splited[2];
      searchKeys.add(key);
      searchValue.add("$value ($price SAR)");
    }
    return searchValue;
  }

  void searchTab(context, index) async {
    var key = searchKeys[index];
    // from here you can pass it to product details
    final product = await getProduct(key);
    Transaction t = Transaction(
        id: key,
        ProductName: product['ProductName'],
        ProductDescription: product['ProductDescription'],
        ProductPrice: double.parse(product['ProductPrice'].toString()),
        date: product['ts'],
        owner: product['Owner'],
        ExpiredDate: product['ExpiredDate']);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(t: t),
      ),
    );
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
                  searchTab(context, index);
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
