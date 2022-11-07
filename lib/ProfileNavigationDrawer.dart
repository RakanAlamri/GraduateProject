import 'package:final_project/AuctionHouse.dart';
import 'package:final_project/BidsPage.dart';
import 'package:flutter/material.dart';
import "HomePage.dart";
import "ProfilePage.dart";
import 'LoginPage.dart';


class ProfileNavigationDrawer extends StatelessWidget {
  const ProfileNavigationDrawer({Key? key}) : super(key: key);

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
            const SizedBox(
              width: 3,
            ),
            const SizedBox(
              width: 70,
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT25dmRWW9XDVDEfjggD1OzyJAsyox9ZWHSLn8-SiwNb3csMCSzOefYpKHa4m6-KfQf4g&usqp=CAU"),
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Column(
              children: [
                Text(
                  Login.Username,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  Login.EMAIL,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
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
              Icons.person_outline,
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
              Icons.balance,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('My Auction'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuctionHouse()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bids()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Notification'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bids()),
              );
            },
          ),
          const Divider(
              color: Colors.black54,
              endIndent: 10.0,
              indent: 10.0,
              height: 10.0),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Settings'),
            onTap: () {
              showDialog(
                context: context, 
                builder: (context) =>  AlertDialog(
                  icon: const Icon(Icons.construction, color: Colors.red, size: 50),
                  title: const Text('This Page Under Construction'), 
                  content: const Text('We are sorry for the inconvenience, but this page is under construction'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  ),
                );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Log Out'),
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
