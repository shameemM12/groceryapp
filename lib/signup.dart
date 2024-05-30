import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/refaction.dart';
import 'package:random_string/random_string.dart';
import 'Services/database.dart';
import 'Services/sharedpreferences.dart';
import 'login_page.dart';

TextEditingController signname = TextEditingController();
TextEditingController signemail = TextEditingController();
TextEditingController signpassword = TextEditingController();
TextEditingController signconpassword = TextEditingController();

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  image: AssetImage(
                      "images/grocery-store-neonbrand-unsplash.webp"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Please sign up to continue",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900])),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: insert(
                        store: signname,
                        fillColor: Colors.green[100],
                        logo: Icon(Icons.perm_contact_cal_sharp),
                        clue: 'First Name',
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: insert(
                        store: signemail,
                        fillColor: Colors.green[100],
                        logo: Icon(Icons.email_outlined),
                        clue: 'Email',
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: signpassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green[100],
                            prefixIconColor: Colors.green[900],
                            prefixIcon: Icon(Icons.password_outlined),
                            suffixIconColor: Colors.green[900],
                            labelText: "Password",
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: signconpassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green[100],
                            prefixIconColor: Colors.green[900],
                            prefixIcon: Icon(Icons.password_outlined),
                            suffixIconColor: Colors.green[900],
                            labelText: "Re enter Password",
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 310,
                      child: MaterialButton(
                        color: Colors.green[900],
                        onPressed: () {
                          signInUser(context);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future signInUser(BuildContext context) async {
  final pass = signpassword.text;
  final con = signconpassword.text;
  if (pass == con) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: signemail.text.trim(), password: signpassword.text.trim());
      print('ok');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => login(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.brown[900],
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text('Account Created Successfully')));
      String Id = randomAlphaNumeric(20);
      Map<String, dynamic> addUserInfo = {
        "Name": signname.text,
        "Email": signemail.text,
        "Wallet": "0",
        "Id": Id,
      };
      await DatabaseMethods().addUserDetail(addUserInfo, Id);
      await SharedPreferenceHelper().saveUserName(signname.text);
      await SharedPreferenceHelper().saveUserEmail(signemail.text);
      await SharedPreferenceHelper().saveUserWallet('0');
      await SharedPreferenceHelper().saveUserId(Id);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue[900],
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text('Try Again $e')));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red[900],
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text('Password does not match')));
  }
}
