import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/Review_CartModel.dart';
import 'package:e_commerce_app/ReviewCart/ReviewCart.dart';
import 'package:e_commerce_app/Screens/LoginScreen/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/Model/Review_CartModel.dart';

class CartProvider with ChangeNotifier{

  Future <void> addCartData( String ProductId ,String CartName, String CartImage ,
      int  Cartprice , int CartQuantity )
     async {
     FirebaseFirestore.instance.collection("cartData").doc(LoginScreen.Userid)
     .collection("cartReviewData")
     .doc(ProductId)
     .set(
         { 'CartId': ProductId,
           'CartName': CartName,
           'CartImage': CartImage,
           'Cartprice': Cartprice,
           'CartQuantity': CartQuantity,
           'isAdd' : true,
         }
     );

     }





  Future <void> UpdateCartData( String ProductId ,String CartName, String CartImage ,
      int  Cartprice , int CartQuantity )
  async {
    FirebaseFirestore.instance.collection("cartData").doc(LoginScreen.Userid)
        .collection("cartReviewData")
        .doc(ProductId)
        .update(
        { 'CartId': ProductId,
          'CartName': CartName,
          'CartImage': CartImage,
          'Cartprice': Cartprice,
          'CartQuantity': CartQuantity,
          'isAdd' : true,
        }
    );

  }
  List<ReviewCartModel> ReviewCartList =[];

  void getReviewCart() async{
    List<ReviewCartModel> newList =[];
   QuerySnapshot snapshot =  await FirebaseFirestore.instance.collection("cartData").doc(LoginScreen.Userid).collection("cartReviewData").get();
    snapshot.docs.forEach((element) {
      ReviewCartModel reviewCart = ReviewCartModel(
        element.get("CartId"),
        element.get('CartName'),
        element.get("CartImage"),
        element.get("Cartprice"),
        element.get("CartQuantity"),
      );
      newList.add(reviewCart);
    });
    ReviewCartList= newList;
    notifyListeners();
  }

   List<ReviewCartModel>  get getReviewCartData {
    return ReviewCartList;
  }


   reviewCartDataDelete(String cartId)async{

     FirebaseFirestore.instance.collection("cartData")
        .doc(LoginScreen.Userid)
        .collection("cartReviewData")
         .doc(cartId)
        .delete();

       notifyListeners();


   }


   getTotalPrice(){
    double totalprice = 0.0;
    ReviewCartList.forEach((element) {
      totalprice += element.CartPrice* element.CartQuantity;
    });
    return totalprice;
   }
}