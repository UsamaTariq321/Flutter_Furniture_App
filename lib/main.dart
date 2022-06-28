import 'package:e_commerce_app/Providers/CartProvider.dart';
import 'package:e_commerce_app/Providers/ProductProvider.dart';
import 'package:e_commerce_app/Providers/UserProvider.dart';
import 'package:e_commerce_app/Providers/WishlistProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Screens/LoginScreen/Login_Screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dart:async';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider<ProductProvider>(
    create:(context)=>ProductProvider(),
    ),
      ChangeNotifierProvider<UserProvider>(
        create:(context)=>UserProvider(),
      ),
      ChangeNotifierProvider<CartProvider>(
        create:(context)=>CartProvider(),
      ),
      ChangeNotifierProvider<WishlistProvider>(
        create:(context)=>WishlistProvider(),
      ),

    ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Get.to(()=>LoginScreen()
            )
        );
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(image: new AssetImage("assets/1.jpg"), fit: BoxFit.cover,),
      ),
    );
  }
}

