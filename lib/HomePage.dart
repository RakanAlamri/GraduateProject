import 'package:final_project/LoginPage.dart';
import 'package:flutter/material.dart';
import 'ProfileNavigationDrawer.dart';
import 'ProductListPage.dart';
import 'Navbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "Firebase/FirebaseAction.dart";

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

void getUserInfo() async {
  Login.EMAIL = (FirebaseAuth.instance.currentUser!.email == null)
      ? ""
      : FirebaseAuth.instance.currentUser!.email!;

  var userinfo = await getUser(FirebaseAuth.instance.currentUser!.uid);
  Login.Username = userinfo['Username'];
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    getUserInfo();

    return MaterialApp(
      home: Scaffold(
          appBar: getAppBar(context),
          drawerScrimColor: Colors.black38,
          drawer: const ProfileNavigationDrawer(),
          body: ProductListPage("home"),
          bottomNavigationBar: getButtonBar(context, setState)),
    );
  }
}
