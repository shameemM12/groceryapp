import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/bottomnavbar.dart';
import 'package:groceryapp/resetpassword.dart';
import 'package:groceryapp/signup.dart';
import 'homepage.dart';

TextEditingController newemail = TextEditingController();
TextEditingController newpassword = TextEditingController();

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 110, right: 60, left: 60),
              child: Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900]),
              ),
            ),
            SizedBox(
              height: 7.5,
            ),
            Text("Login to your Account",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey)),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: newemail,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green[100],
                    prefixIconColor: Colors.green[900],
                    prefixIcon: Icon(Icons.email_outlined),
                    suffixIconColor: Colors.green[900],
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: newpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green[100],
                    prefixIconColor: Colors.green[900],
                    prefixIcon: Icon(Icons.password_outlined),
                    suffixIconColor: Colors.green[900],
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => againpass(),
                          ));
                    },
                    child: Text("Forgot Password?"))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: MaterialButton(
                onPressed: () {
                  signInUser(context);
                },
                child: Center(
                    child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => signup(),
                          ));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green[900]),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> signInUser(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: newemail.text.trim(), password: newpassword.text.trim());
    print('ok');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => bottomnavbar(),
        ));
  } on FirebaseAuthException catch (e) {
    final errorMessage = 'Email and password do not match';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green[900],
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text('Email and password do not match')));
  }
}
