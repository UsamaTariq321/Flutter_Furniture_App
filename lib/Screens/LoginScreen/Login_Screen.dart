import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Providers/UserProvider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../Widgets/button.dart';
import '../../constants.dart';
import '../HomeScreen/HomeScreen.dart';
import '../RegisterScreen/SignUp_Screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
class LoginScreen extends StatefulWidget {
  static String Userid="";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserProvider userProvider;
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;



  Future<User?> _googleSignUp() async{
    try{
      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email'],);
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleuser?.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,

      );
      final User? user =  (await auth.signInWithCredential(authCredential)).user;

      userProvider.addUser(
          user!,
          user.displayName!,
          user.email!,
          user.phoneNumber!,
          user.photoURL!);

      return user;
    }catch(e){
      print("failed");
    }






  }



  @override
  Widget build(BuildContext context) {
      userProvider= Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            /* add child content here */
            child: isloading
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
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter Email";
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email',
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
                                  hintText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  )),
                            ),
                            SizedBox(height: 80),
                            LoginSignupButton(
                              title: 'LOGIN',
                              ontapp: () async {
                                var collection =
                                FirebaseFirestore.instance.collection('users');
                                var querySnapshot = await collection.get();
                                for (var queryDocumentSnapshot
                                in querySnapshot.docs) {
                                  Map<String, dynamic> data =
                                  queryDocumentSnapshot.data();

                                  var emails = data['email'];
                                  var pass1 = data['password'];
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      isloading = true;
                                    });
                                    try {
                                      if(email == emails && password == pass1)
                                      {
                                       LoginScreen.Userid = queryDocumentSnapshot.id;
                                       Fluttertoast.showToast(msg: "Successfully Login" ,);
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (contex) => HomeScreen(),
                                          ),
                                        );
                                      }
                                      setState(() {
                                        isloading = false;
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text("Ops! Login Failed"),
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
                                      print(e);
                                    }
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                }

                              },
                            ),
                            SizedBox(height: 30),
                            SignInButton(
                                Buttons.Google,
                                text: "Sign In With Google",
                                onPressed: (){
                                  _googleSignUp().then((value) =>
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder:
                                              (context)=> HomeScreen())));
                            }),
                            
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Don't have an Account ?",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black87),
                                  ),
                                  SizedBox(width: 10),
                                  Hero(
                                    tag: '1',
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}

