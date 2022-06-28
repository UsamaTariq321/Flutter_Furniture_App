import 'package:e_commerce_app/Providers/CartProvider.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  bool isBool=false;
  String ProductName;
  Function onDelete;
  String ProductImage;
  int ProductPrice;
  String ProductId;
  int ProductQuantity;
  bool wishList;

  SingleItem(this.ProductId,this.onDelete,this.isBool , this.ProductName,this.ProductImage,this.ProductPrice , this.ProductQuantity, this.wishList);
  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late CartProvider cartProvider;
  late int count;

  getCount(){
    setState(() {
      count = widget.ProductQuantity;
    });

  }



  Widget build(BuildContext context) {
    getCount();
    cartProvider = Provider.of(context);
    cartProvider.getReviewCart();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10),
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Image.network(widget.ProductImage),
                      ),
                    ),
                  )
              ),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: widget.isBool == false ?MainAxisAlignment.spaceAround : MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(widget.ProductName,
                                style:  TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                              Text("Price :${widget.ProductPrice}",
                                style:  TextStyle(color: Colors.black , fontSize: 14),),

                            ],
                          ),
                          widget.isBool == false ?  Container(
                          ): Text("Total :${widget.ProductPrice*count}")
                        ],
                      ),
                    ),
                  )
              ),
              Expanded(
                  child: Container(
                    height: 100,
                    padding: widget.isBool == false ? EdgeInsets.symmetric(horizontal: 15,vertical: 32): EdgeInsets.only(left: 15,right: 15),
                    child: widget.isBool == false ?
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),

                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: primaryColor,
                              size: 20,
                            ),
                            Text("ADD",
                              style:  TextStyle(color: primaryColor ),),
                          ],
                        ),
                      ),

                    ): Column(
                      children: [
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            widget.onDelete();
                          },
                          child: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 20,),
                        widget.wishList==true
                            ? Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),

                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                     if(count==1)
                                       {
                                         Fluttertoast.showToast(msg: "you reach minimum limit" ,);
                                       }
                                     else{
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
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text("$count",
                                  style:  TextStyle(color: Colors.black ),),
                                SizedBox(width: 10,),

                                InkWell(
                                  onTap: (){
                                    if(count<5){
                                      setState(() {
                                        count++;
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
                                    Icons.add,
                                    color:Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ):Column()
                      ],
                    ),
                  )
              ),


            ],
          ),
        ),
        widget.isBool == false?Container():Divider(
          height: 1,
          color: Colors.black54,
        )
      ],
    );
  }
}

