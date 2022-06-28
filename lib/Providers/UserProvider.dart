import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/UserModel.dart';
import 'package:e_commerce_app/Screens/LoginScreen/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{

  void addUser(User currentUser , String Username, String Email , String Number , String UserImage ) async{
  await  FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set(
      {
          "username": Username,
             "Email": Email,
          "PhoneNumber": Number,
         "UserImage": UserImage,
            "UserId":currentUser.uid,
      },
    );
  }

  late UserModel currentData;
  void getAllUser( ) async{
    UserModel userModel;
  var value =   await  FirebaseFirestore.instance.collection("users").doc(LoginScreen.Userid).get();
    if(value.exists){
          userModel = UserModel( value.get("username"), value.get("email"));
          currentData=userModel;
          notifyListeners();

    }
  }


  UserModel  get currentUserData{
    return currentData;
  }

}