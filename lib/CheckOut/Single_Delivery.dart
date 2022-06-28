import 'package:e_commerce_app/Widgets/Count.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/material.dart';
class SingleDelivery extends StatelessWidget {

  final String title;
  final String Number;
  final String address;

  SingleDelivery(this.title, this.Number, this.address, this.addresstype);

  final String addresstype;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)

                ),
                child: Center(
                  child: Text(addresstype,style: TextStyle(fontSize: 13,color: Colors.white),),
                ),
              )
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: primaryColor,

          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(height: 5,),
              Text(Number),

            ],
          ),
        ),
        Divider(
          height: 35,
        )

      ],

    );
  }
}
