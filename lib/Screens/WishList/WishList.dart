import 'package:e_commerce_app/Model/Review_CartModel.dart';
import 'package:e_commerce_app/Providers/CartProvider.dart';
import 'package:e_commerce_app/Providers/WishlistProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../Model/ProductModel.dart';
import '../../Model/WishListData.dart';
import '../../Providers/ProductProvider.dart';
import '../../Widgets/Single_item.dart';
import '../../config/Colors.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => WishListState();
}

class WishListState extends State<WishList> {

  late WishlistProvider wishlistProvider;
  showAlertDialog(BuildContext context , WishListData wishListData) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        wishlistProvider.deleteWishlistData(wishListData.WishlistId);
        Fluttertoast.showToast(msg: "Removed From WishList" ,);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wishlist Product"),
      content: Text("Are You Delete Your WishList Product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
      wishlistProvider = Provider.of(context);
      wishlistProvider.getWishListData();
    return Scaffold(
        backgroundColor: scaffoldbackgroundColor,
        appBar: AppBar(
          backgroundColor: scaffoldbackgroundColor,
          iconTheme: IconThemeData(color: textColor),
          title: Text("WishList", style: TextStyle(color: Colors.black),),
        ),
        body: ListView.builder(
          itemCount: wishlistProvider.WishListDataGet.length,
          itemBuilder: (context,index){
            WishListData wishList = wishlistProvider.WishListDataGet[index];
            return  Column(
              children: [
                SizedBox(height: 10,),
                SingleItem(
                    wishList.WishlistId,(){
                  showAlertDialog(context , wishList);
                    },
                      true ,wishList.WishlistName,wishList.WishlistImage,wishList.WishlistPrice,wishList.ProductQuantity, false),
              ],
            );

          },
        )

    );
  }
}
