import 'package:e_commerce_app/Model/Review_CartModel.dart';
import 'package:e_commerce_app/Providers/CartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CheckOut/DeliveryDetails.dart';
import '../Model/ProductModel.dart';
import '../Providers/ProductProvider.dart';
import '../Widgets/Single_item.dart';
import '../config/Colors.dart';
class ReviewCart extends StatefulWidget {
  late final List<ProductModel>  search;
  ReviewCart({required this.search});


  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late CartProvider cartProvider;
  showAlertDialog(BuildContext context , ReviewCartModel reviewCartModel) {

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
        cartProvider.reviewCartDataDelete(reviewCartModel.CartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are You Delete Your Cart Product?"),
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

  late ProductProvider productProvider;
  @override
  void initState() {
    productProvider = Provider.of(context , listen: false);
    productProvider.fetchDoubleBed();
    productProvider.fetchSingleBed();
    productProvider.fetchSofaSet();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  cartProvider = Provider.of(context);
    cartProvider.getReviewCart();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text("${cartProvider.getTotalPrice()}"),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeliveryDetails()));
            },
            child: Text("Submit"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
          ),
        ),
      ),
      backgroundColor: scaffoldbackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldbackgroundColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Review Cart", style: TextStyle(color: Colors.black),),
      ),
      body: cartProvider.getReviewCartData.isEmpty?Center(
        child: Text("NO DATA"),
      ):ListView.builder(
        itemCount: cartProvider.getReviewCartData.length,
        itemBuilder: (context,index){
          ReviewCartModel reviewCartModel = cartProvider.getReviewCartData[index];
          return  Column(
            children: [
              SizedBox(height: 10,),
              SingleItem(
                       reviewCartModel.CartId,
                       (){
                         showAlertDialog(context , reviewCartModel);
                        },
                  true ,
                  reviewCartModel.CartName,
                  reviewCartModel.CartImage,
                  reviewCartModel.CartPrice,
                  reviewCartModel.CartQuantity ,
                  true),
            ],
          );

        },
      )

    );
  }
}
