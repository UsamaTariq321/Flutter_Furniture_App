import 'package:e_commerce_app/Providers/ProductProvider.dart';
import 'package:e_commerce_app/Providers/UserProvider.dart';
import 'package:e_commerce_app/ReviewCart/ReviewCart.dart';
import 'package:e_commerce_app/Screens/HomeScreen/HomeScreen.dart';
import 'package:e_commerce_app/Screens/MyProfileScreen/MyProfile.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/WishList/WishList.dart';

class DrawerSide extends StatefulWidget {
   UserProvider userProvider;
   DrawerSide(this.userProvider);

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
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
  Widget build(BuildContext context) {

    var userData = widget.userProvider.currentData;

    Widget listTitle(IconData iconData , String title , Function ontap){
      return ListTile(
        onTap: (){
          ontap();
        },
        leading: Icon(
          iconData,
          size: 32,
        ),
        title: Text(title, style: TextStyle(color: Colors.black45),),
      );
    }
    return Drawer(
      child: Container(
        color: scaffoldbackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 43,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage("https://i.pinimg.com/600x315/47/7f/a4/477fa4df6509e5120468638e7ab14d22.jpg") ,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(userData.Username, style: TextStyle(),),
                    ),
                    SizedBox(height: 7,),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 25,
                        child: Text(userData.Email, style: TextStyle(),),
                      ),
                    )
                  ],
                )
              ],
            )
            ),
            listTitle(Icons.home_outlined,"Home" ,(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
            }),
            listTitle(Icons.shop_outlined,"Review Cart",(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReviewCart( search: productProvider.SearchAllProduct,)));
            }),
            listTitle(Icons.person_outlined,"MyProfile",(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyProfile(widget.userProvider)));
            }),
            listTitle(Icons.notifications_outlined,"Notification",(){}),
            listTitle(Icons.star_outlined,"Rating & Review",(){}),
            listTitle(Icons.favorite_outlined,"WishList",(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WishList()));
            }),
            listTitle(Icons.copy_outlined,"Raise a Complaint",(){}),
            listTitle(Icons.format_quote_outlined,"FAQs",(){}),

            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Support"),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Call Us:"),
                      SizedBox(width: 10,),
                      Text("+92 03033354121"),

                    ],
                  ),
                  SizedBox(height: 5,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text("Mail Us:"),
                        SizedBox(width: 10,),
                        Text("tusama134@gmail.com"),

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

