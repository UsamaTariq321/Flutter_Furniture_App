import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Providers/CartProvider.dart';
import 'package:e_commerce_app/Screens/LoginScreen/Login_Screen.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Count extends StatefulWidget {
  String ProductName;
  String ProductImage;
  int ProductPrice;
  String ProductId;

  Count(this.ProductId,this.ProductName, this.ProductImage,
       this.ProductPrice);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  getAddandQuantity(){
    FirebaseFirestore.instance.collection("cartData").doc(LoginScreen.Userid)
        .collection("cartReviewData")
        .doc(widget.ProductId)
        .get().then((value) => {
          if(this.mounted){
            if(value.exists){
              setState((){
                count = value.get("CartQuantity");
                isTrue = value.get("isAdd");
              })
            }

          }
    });
  }

  @override
  Widget build(BuildContext context) {
    getAddandQuantity();
    CartProvider cartProvider = Provider.of(context);
    return Container(
    child:  Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40 ,top: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:isTrue == true ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(count==1)
                        {
                          setState(() {
                            isTrue = false;
                          });
                          cartProvider.reviewCartDataDelete(widget.ProductId);
                        }
                        else if(count>1){
                          setState(() {
                            count--;
                          });
                          cartProvider.UpdateCartData(
                              widget.ProductId,
                              widget.ProductName,
                              widget.ProductImage,
                              widget.ProductPrice,
                              count);

                        }


                      },
                      child: Icon(
                        Icons.remove,
                        size: 17,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text("${count}"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                         count++;
                        });
                        cartProvider.UpdateCartData(
                          widget.ProductId,
                          widget.ProductName,
                          widget.ProductImage,
                          widget.ProductPrice,
                          count);
                      },
                      child: Icon(
                        Icons.add,
                        size: 17,
                        color: Colors.orange,
                      ),
                    )
                  ],
                ):Center(
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        isTrue = true;
                      });
                      cartProvider.addCartData(
                          widget.ProductId,
                          widget.ProductName,
                          widget.ProductImage,
                          widget.ProductPrice,
                          count,
                        );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ADD",
                          style: TextStyle(color:  Colors.black, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                )
              ),
            ),
          )
        ],
      )

    );
  }
}
