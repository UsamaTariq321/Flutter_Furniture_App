import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Providers/WishlistProvider.dart';
import 'package:e_commerce_app/ReviewCart/ReviewCart.dart';
import 'package:e_commerce_app/Screens/LoginScreen/Login_Screen.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../Widgets/Count.dart';


enum SignInCharacter {fill,outline}

class ProductOverview extends StatefulWidget {

  final String ProductName;
  final String ProductImage;
  final int ProductPrice;
  final String ProductId;


   ProductOverview({required this.ProductId,required this.ProductName,required this.ProductImage , required this.ProductPrice});

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {

  SignInCharacter _character = SignInCharacter.fill;
  bool WishlistBool = false;




  Widget BottomNavigatorBar({
    required Color iconColor ,
    required Color BackgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required Function onTap,
  }){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Expanded(
        child: Container(
          padding: EdgeInsets.all(15),
          color: BackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(width: 5,),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 20
                ),
              )

            ],
          ),
        ),
      ),
    );
  }



  getwishListBool(){
    FirebaseFirestore.instance
        .collection("WishListdata")
        .doc(LoginScreen.Userid)
        .collection("ReviewWishListData")
         .doc(widget.ProductId)
        .get().then((value) => {
             setState(() {
              if(value.exists){
               WishlistBool = value.get("Wishlist");
                  }
                })

    });
  }

  @override
  Widget build(BuildContext context) {
   WishlistProvider wishlistProvider = Provider.of(context);

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomNavigatorBar(
              iconColor: Colors.grey,
              BackgroundColor: Colors.red,
              color: Colors.white,
              title: "Add To WishList",
              iconData: WishlistBool == false ?Icons.favorite_border:
              Icons.favorite_sharp,
            onTap: (){
              getwishListBool();
                setState(() {
                  WishlistBool = !WishlistBool;
                });
                if(WishlistBool == true){
                  Fluttertoast.showToast(msg: "Add Product To WishList" ,);
                  wishlistProvider.addWhishListData(
                      widget.ProductId,
                      widget.ProductName,
                      widget.ProductImage,
                      widget.ProductPrice,
                  );
                }
                else{
                  Fluttertoast.showToast(msg: "Un Favourite" ,);
                  wishlistProvider.deleteWishlistData(widget.ProductId);
                }
            }
          ),
          BottomNavigatorBar(
              iconColor: Colors.white
              , BackgroundColor: primaryColor,
              color: textColor,
              title: "Go To Cart",
              iconData: Icons.shop_outlined,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ReviewCart(search: [])));

              }
          )
        ],
      ),
      appBar: AppBar(
      title: Text("Product Overview" , style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white70,
      iconTheme: IconThemeData(color: textColor),
    ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(widget.ProductName),
                      subtitle: Text("${widget.ProductPrice}"),
                    ),
                    Container(
                      height: 210,
                      padding: EdgeInsets.all(40),
                      child: Image.network(widget.ProductImage),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text(
                        "Available Options",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600
                        ),
                      ),


                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.green.shade700,
                                ),
                                Radio(
                                  value: SignInCharacter.fill,
                                  groupValue: _character,
                                  activeColor: Colors.green[700],
                                  onChanged: (value){
                                    setState(() {
                                      _character= value as SignInCharacter;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Center(child: Text("Product Price : ${widget.ProductPrice}")),

                          Padding(
                            padding: EdgeInsets.only(left: 90,right: 120),
                            child: Count(
                              widget.ProductId,
                              widget.ProductName,
                              widget.ProductImage,
                              widget.ProductPrice,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),

          )),
          Expanded(child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text("About This Product" ,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                SizedBox(height: 10,),

                Text("In marketing, a product is an object, or system, or service made available for consumer "
                    "use as of the consumer demand; it is anything that can be offered to a market "
                    "to satisfy the desire or need of a customer. Wikipedia" ,
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor
                  ),
                ),
              ],
            ),
          ))
        ],
      ),





    );
  }
}
