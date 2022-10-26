import 'package:final_project/HomePage.dart';
import 'package:final_project/LoginPage.dart';
import 'package:final_project/ProfilePage.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Padding(
            padding: const EdgeInsets.only(left: 77),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ZAWD',
                  style: TextStyle(
                    fontFamily: 'Bellota',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        drawerScrimColor: Colors.black38,
        drawer: const NavigationDrawer(),
        body: Text(
          'This Page Is Under Instruction',
          style: TextStyle(
            fontFamily: 'Bellota',
            fontSize: 40,
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        color: Colors.lightBlueAccent,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT25dmRWW9XDVDEfjggD1OzyJAsyox9ZWHSLn8-SiwNb3csMCSzOefYpKHa4m6-KfQf4g&usqp=CAU"),
            ),
            Column(
              children: [
                Text(
                  'Yazeed Aloraini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'yazeed@gmail.com',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.home_filled,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.star,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Auction House'),
            onTap: () {
              print('side auction house is working');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Bids'),
            onTap: () {
              print('side bids is working');
            },
          ),
          SizedBox(
            height: 300,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Log Out'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      );
}
