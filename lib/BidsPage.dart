import 'package:flutter/material.dart';
import 'package:final_project/ProfileNavigationDrawer.dart';
import 'Navbars.dart';
import 'HomePage.dart';
import 'ProductListPage.dart';

class Bids extends StatefulWidget {
  const Bids({super.key});

  @override
  State<Bids> createState() => _BidsState();
}

class _BidsState extends State<Bids> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: getAppBar(context),
        drawerScrimColor: Colors.black38,
        drawer: ProfileNavigationDrawer(),
        body: ProductListPage("bids"),
        bottomNavigationBar: getButtonBar(context, setState),
      ),
    );
  }
}
