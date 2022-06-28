import 'package:e_commerce_app/Screens/LoginScreen/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Widgets/button.dart';
import '../../constants.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  static String email = '';
  static String password = '';
  static String username='';
  static double number=0;
  bool isloading = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() async {
    // Call the user's CollectionReference to add a new user
    print(email+ ""+password);
    return users
        .add({
      'email': email,
      'password': password,
      'phone': number,
      'username': username,
    })
        .then((value) => print("added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child : isloading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Form(
            key: formkey,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,

                    child: SingleChildScrollView(
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: '1',
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              username = value.toString().trim();
                            },
                            validator: (value) => (value!.isEmpty)
                                ? ' Please enter Username'
                                : null,
                            textAlign: TextAlign.center,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter Your Username',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value.toString().trim();
                            },
                            validator: (value) => (value!.isEmpty)
                                ? ' Please enter Email'
                                : null,
                            textAlign: TextAlign.center,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Password";
                              }
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            textAlign: TextAlign.center,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Choose a Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                )),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              number = double.parse(value);
                            },
                            validator: (value) => (value!.isEmpty)
                                ? ' Please enter PhoneNumber'
                                : null,
                            textAlign: TextAlign.center,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter Your PhoneNumber',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          LoginSignupButton(
                            title: 'Register',
                            ontapp: () async {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                try {
                                  addUser();
                                  Fluttertoast.showToast(msg: "User Register Successfully" ,);
                                  Navigator.of(context).pop();

                                  setState(() {
                                    isloading = false;
                                  });
                                } on FirebaseAuthException catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title:
                                      Text(' Ops! Registration Failed'),
                                      content: Text('${e.message}'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text('Okay'),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                setState(() {
                                  isloading = false;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Already have an Account ?",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87),
                                ),
                                SizedBox(width: 10),
                                Hero(
                                  tag: '1',
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
