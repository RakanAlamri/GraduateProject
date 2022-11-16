import 'package:final_project/HomePage.dart';
import 'package:final_project/ProfileNavigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Firebase/FirebaseAction.dart';
import 'LoginPage.dart';
import 'Navbars.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  void changeInformation(String phone, String password) async {
    if (password.isNotEmpty) {
      print('pass is not empty');
      //Create an instance of the current user.
      User? user = FirebaseAuth.instance.currentUser;

      //Pass in the password to updatePassword.
      user?.updatePassword(password).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    }

    if (phone.isNotEmpty) {
      Login.Phone = phone;
      updatePhone(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneController = TextEditingController();
    usernameController.text = Login.Username;
    emailController.text = Login.EMAIL;
    phoneController.text = Login.Phone;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: getAppBar(context),
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
                            enabled: false,
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Username',
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
                            enabled: false,
                            controller: emailController,
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
                        // child: TextFormField(
                        //   controller: passwordController,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   onChanged: (String value) {},
                        //   decoration: const InputDecoration(
                        //     labelText: 'new password',
                        //     hintText: 'update password',
                        //     prefixIcon: Icon(Icons.lock_outline),
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (value) {
                        //     return value!.isEmpty
                        //         ? 'Please enter password'
                        //         : null;
                        //   },
                        // ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'phone number',
                            hintText: 'phone number',
                            prefixIcon: Icon(Icons.phone_iphone_rounded),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () {
                            changeInformation(
                                phoneController.text, passwordController.text);
                          },
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
