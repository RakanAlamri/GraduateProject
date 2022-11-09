// ignore_for_file: unnecessary_const

import 'HomePage.dart';
import 'package:final_project/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static String EMAIL = "";
  static String Username = "";
  late _LoginState state;

  @override
  State<Login> createState() {
    this.state = _LoginState();
    return state;
  }
}

enum LOGIN_STATE {
  None,
  Successful,
  Wrong,
  Error,
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void Login(context, email, password) async {
    LOGIN_STATE e = await ValidateLogin(email, password);
    if (e == LOGIN_STATE.Successful) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  Future<LOGIN_STATE> ValidateLogin(email, password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return LOGIN_STATE.Successful;
    } on FirebaseAuthException catch (e) {
      return LOGIN_STATE.Wrong;
    } catch (e) {
      print(e);
      return LOGIN_STATE.Error;
    }
  }

  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Padding(
              //   padding: EdgeInsets.only(top: 100),
              //   child: Text(
              //     'Zawd',
              //     style: TextStyle(
              //         fontFamily: 'Bellota',
              //         fontSize: 35,
              //         color: Colors.lightBlueAccent,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage("assets/Logo/ZAWD.jpg"),
                  height: 220,
                  width: 220,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'email',
                            prefixIcon: Icon(Icons.mail_outline_outlined),
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
                        controller: passwordController,
                        obscureText: obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          border: const OutlineInputBorder(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                          ),
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
                          Login(context, usernameController.text,
                              passwordController.text);
                        },
                        color: Colors.lightBlueAccent,
                        textColor: Colors.black,
                        minWidth: 170,
                        child: const Text('Login'),
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 115),
                          child: Text(
                            'Not yet registered?',
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
                                    builder: (context) => Signup()),
                              );
                            },
                            minWidth: 0,
                            textColor: Colors.lightBlueAccent,
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
