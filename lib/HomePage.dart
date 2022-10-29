import 'package:flutter/material.dart';
import 'ProfileNavigationDrawer.dart';
import 'ProductListPage.dart';
import 'Navbars.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: getAppBar(context),
          drawerScrimColor: Colors.black38,
          drawer: const ProfileNavigationDrawer(),
          body: ProductListPage(),
          bottomNavigationBar: getButtonBar(context, setState)),
    );
  }
}
