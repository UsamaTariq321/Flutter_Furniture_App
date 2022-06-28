import 'package:e_commerce_app/Model/ProductModel.dart';
import 'package:e_commerce_app/Widgets/Single_item.dart';
import 'package:e_commerce_app/config/Colors.dart';
import 'package:flutter/material.dart';
class Search extends StatefulWidget {
  late final List<ProductModel>  search;
  Search({required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String Query="";


  SearchItem(String query){
    List<ProductModel> searchFood= widget.search.where((element) {
      return element.ProductName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchitem = SearchItem(Query);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: scaffoldbackgroundColor,
        title: Text("Search",
          style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.menu_rounded, color: Colors.black,),
          ),

        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Items"),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 52,
              child: TextField(
                onChanged: (value){
                  print(value);
                  setState(() {
                    Query = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color(0xffc2c2c2),
                  filled: true,
                  hintText: "Search For Items In the Store",
                  suffixIcon: Icon(Icons.search),
                ),
              )
          ),
          SizedBox(height: 10,),
          Column(
            children: searchitem.map((data) {
              return  SingleItem("",(){},false , data.ProductName,data.ProductImage,data.ProductPrice,0,false);
            } ).toList(),
          )
        ],
      ),
    );
  }
}
