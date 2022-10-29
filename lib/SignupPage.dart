import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Firebase/FirebaseAction.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  void signup(email, password, username, phone) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AddNewUser({'Email': email, 'Username': username, 'Phone': phone});

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontFamily: 'Bellota',
                    fontSize: 35,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 120),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'username',
                            hintText: 'username',
                            prefixIcon: Icon(Icons.account_circle_rounded),
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
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'email',
                            hintText: 'email',
                            prefixIcon: Icon(Icons.mail),
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
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'password',
                          hintText: 'password',
                          prefixIcon: Icon(Icons.lock),
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
                        controller: phoneController,
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
                        onPressed: () {
                          signup(emailController.text, passwordController.text,
                              usernameController.text, phoneController.text);
                        },
                        child: const Text('Sign up'),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.black,
                        minWidth: 170,
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 115),
                          child: Text(
                            'Already have account?',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 45),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            minWidth: 0,
                            textColor: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
