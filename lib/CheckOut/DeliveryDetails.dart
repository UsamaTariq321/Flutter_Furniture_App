
import 'package:e_commerce_app/CheckOut/Single_Delivery.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/material.dart';
class DeliveryDetails extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldbackgroundColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Delivery Details", style: TextStyle(color: Colors.black),),
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: (){},
      ),
      bottomNavigationBar: Container(
        height: 49,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: MaterialButton(
          child: Text("Add New Address"),
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          onPressed: (){},
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Delivery To"),
            leading: Image.asset("assets/2.jpg", height: 30,),

          ),
          Divider(
            height: 1,
          ),
          Column(
            children: [
              SingleDelivery(
                "Usama Tariq",
                "area , Gulshan e Moazam Bin Qasim Karachi",
                  "03033354121",
                "Home"

              ),
            ],
          )
        ],
      ),
    );
  }
}
