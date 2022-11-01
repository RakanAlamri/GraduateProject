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

Future<Map<dynamic, dynamic>> getUserInfo() async {
  Login.EMAIL = (FirebaseAuth.instance.currentUser!.email == null)
      ? ""
      : FirebaseAuth.instance.currentUser!.email!;

  final userInfo = await getUser(FirebaseAuth.instance.currentUser!.uid);
  return userInfo;
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if (Login.Username.isEmpty) {
      return FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Login.Username = snapshot.data!['Username'];

            return MaterialApp(
              home: Scaffold(
                  appBar: getAppBar(context),
                  drawerScrimColor: Colors.black38,
                  drawer: const ProfileNavigationDrawer(),
                  body: ProductListPage("home"),
                  bottomNavigationBar: getButtonBar(context, setState)),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    } else {
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
}
