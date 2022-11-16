import 'package:final_project/HomePage.dart';
import 'package:final_project/ProfileNavigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Firebase/FirebaseAction.dart';
import 'LoginPage.dart';

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
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_outlined)),
            ],
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
                ],
              ),
            )),
        drawerScrimColor: Colors.black38,
        drawer: const ProfileNavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
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
                              labelText: 'Login.Username.toString()',
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
                              return value!.isEmpty
                                  ? 'Please enter email'
                                  : null;
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
                          color: Colors.lightBlueAccent,
                          textColor: Colors.black,
                          minWidth: 170,
                          child: const Text('Confirm'),
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
