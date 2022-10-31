import 'package:final_project/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Firebase/FirebaseAction.dart';
import 'LoginPage.dart';
import 'SettingsPage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
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
                  Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            )),
        drawerScrimColor: Colors.black38,
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: const Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Bellota',
                      fontSize: 35,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'username',
                              hintText: 'username',
                              prefixIcon: Icon(Icons.account_circle_outlined),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter username'
                                  : null;
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'email',
                              hintText: 'email',
                              prefixIcon: Icon(Icons.mail_outline),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty ? 'Please enter email' : null;
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (String value) {},
                          decoration: const InputDecoration(
                            labelText: 'password',
                            hintText: 'password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter password'
                                : null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (String value) {},
                          decoration: const InputDecoration(
                            labelText: 'phone number',
                            hintText: 'phone number',
                            prefixIcon: Icon(Icons.phone_iphone_rounded),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter password'
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () {},
                          child: const Text('Edit Profile'),
                          color: Colors.lightBlueAccent,
                          textColor: Colors.black,
                          minWidth: 170,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
