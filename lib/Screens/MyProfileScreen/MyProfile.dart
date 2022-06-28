import 'package:e_commerce_app/Providers/UserProvider.dart';
import 'package:e_commerce_app/Widgets/DrawerSide.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/material.dart';
class MyProfile extends StatelessWidget {
  UserProvider userProvider;
  MyProfile(this.userProvider);


  Widget listTile(IconData iconData , String title){
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(iconData),
        title:  Text(title),
        trailing:  Icon(Icons.arrow_forward_ios),
         )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userdata = userProvider.currentData;
    return Scaffold(
      drawer: DrawerSide(userProvider),
      backgroundColor: primaryColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text("MyProfile" ,
        style: TextStyle(
            color: Colors.black,
        fontSize: 18),
        ),
        backgroundColor: scaffoldbackgroundColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primaryColor,
              ),
              Container(
                height: 546,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: scaffoldbackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  )
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 80,
                          width: 250,
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(userdata.Username ,
                                     style: TextStyle
                                       (
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold
                                   ),),
                                  SizedBox(height: 10,),
                                  Text(userdata.Email)

                                ],
                              ),
                              CircleAvatar(
                               radius: 15,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                      Icons.edit,
                                    color: primaryColor,
                                  ),
                                  backgroundColor: scaffoldbackgroundColor,
                                ),
                              )
                            ],
                          ),

                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    listTile(Icons.shop_outlined, "MyOrders"),
                    listTile(Icons.location_on_outlined, "MyDeliveryAddress"),
                    listTile(Icons.person_outlined, "Refer A Friend"),
                    listTile(Icons.file_copy_outlined, "Terms & Conditions"),
                    listTile(Icons.policy_outlined, "Privacy Policy"),
                    listTile(Icons.add_chart_outlined, "About"),
                    listTile(Icons.exit_to_app_outlined, "LogOut"),
                  ],
                ),


              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 30),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.brown,
                backgroundImage: NetworkImage("https://i.pinimg.com/600x315/47/7f/a4/477fa4df6509e5120468638e7ab14d22.jpg"),

              ),
            ),
          )


        ],

      ),
    );
  }
}
