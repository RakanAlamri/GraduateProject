import 'package:flutter/material.dart';
import 'ProfileNavigationDrawer.dart';
import 'ProductListPage.dart';
import 'Navbars.dart';

class AuctionHouse extends StatefulWidget {
  @override
  State<AuctionHouse> createState() => _HomeState();
}

class _HomeState extends State<AuctionHouse> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: getAppBar(context),
          drawerScrimColor: Colors.black38,
          drawer: ProfileNavigationDrawer(),
          body: ProductListPage("auction"),
          bottomNavigationBar: getButtonBar(context, setState)),
    );
  }
}
