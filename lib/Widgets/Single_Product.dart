import 'package:e_commerce_app/Screens/ProductOverview/Product_Overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Count.dart';

class SingleProduct extends StatelessWidget {
  final String productImage;
  final String  productName;
   Function onTap;
   final int Price;
    String ProductId;
 SingleProduct({required this.ProductId,required this.productImage , required this.productName ,required this.onTap , required this.Price });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 220,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              onTap();
            },
            child: Container(
              height: 150,
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Image.network(productImage),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( productName, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("Price : ${Price}" , style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Count(
                    ProductId,
                    productName,
                    productImage,
                    Price,
                  ),


                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}

