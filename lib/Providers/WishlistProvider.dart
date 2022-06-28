import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/ProductModel.dart';
import 'package:flutter/cupertino.dart';

import '../Model/WishListData.dart';
import '../Screens/LoginScreen/Login_Screen.dart';

class WishlistProvider with ChangeNotifier{

//////////////////////////addwishListData
  Future <void> addWhishListData( String WishlistId ,String WishlistName, String WishlistImage ,
      int Wishlistprice)
  async {
    FirebaseFirestore.instance.collection("WishListdata")
        .doc(LoginScreen.Userid)
        .collection("ReviewWishListData")
        .doc(WishlistId)
        .set(
        { 'WishlistId': WishlistId,
          'WishlistName': WishlistName,
          'WishlistImage':WishlistImage,
          'Wishlistprice': Wishlistprice,
          'Wishlist' : true,
          'WishListQuantity': 12
        }
    );

  }



  ///////////////////////// get wishlist data
  List<WishListData> wishList = [];

  getWishListData() async{
    List<WishListData> newList = [];
  QuerySnapshot snapshot =   await FirebaseFirestore.instance
      .collection("WishListdata")
        .doc(LoginScreen.Userid)
        .collection("ReviewWishListData")
        .get();

       snapshot.docs.forEach((element) {
         WishListData productModel = WishListData(
             element.get("WishlistId"),
               element.get("WishlistName"),
               element.get("WishlistImage"),
             element.get("Wishlistprice"),
             element.get("Wishlist"),
             element.get("WishListQuantity")
           );
           newList.add(productModel);
       });
       wishList=newList;
       notifyListeners();

  }

  List<WishListData> get WishListDataGet {
    return wishList;
  }




  ///////////////// delete wishlistData

   deleteWishlistData(String cartId){
     FirebaseFirestore.instance.collection("WishListdata")
         .doc(LoginScreen.Userid)
         .collection("ReviewWishListData")
         .doc(cartId)
         .delete();

     notifyListeners();

   }









}