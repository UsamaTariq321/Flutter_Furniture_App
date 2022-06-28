import 'package:e_commerce_app/Providers/ProductProvider.dart';
import 'package:e_commerce_app/Providers/UserProvider.dart';
import 'package:e_commerce_app/Screens/ProductOverview/Product_Overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ReviewCart/ReviewCart.dart';
import '../../config/Colors.dart';
import '../../Widgets/DrawerSide.dart';
import '../Search/Search.dart';
import '../../Widgets/Single_Product.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ProductProvider productProvider;

  Widget listTitle(IconData iconData , String title){
    return ListTile(
      leading: Icon(
        iconData,
        size: 32,
      ),
      title: Text(title, style: TextStyle(color: Colors.black45),),
    );
  }


  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context , listen: false);
    productProvider.fetchDoubleBed();
    productProvider.fetchSingleBed();
    productProvider.fetchSofaSet();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getAllUser();

    return Scaffold(
      backgroundColor: scaffoldbackgroundColor,
      drawer: DrawerSide(userProvider),
      appBar:  AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Home" ,style: TextStyle(
            color: textColor,
            fontSize: 22
        )),
        backgroundColor: scaffoldbackgroundColor,
        actions: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xffd4d181),
            child: IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Search(
                  search: productProvider.SearchAllProduct,
                )));
              },
                icon: Icon(Icons.search, size: 17 , color: textColor,)),
          ),
          Padding(
            padding: const EdgeInsets.all( 15),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ReviewCart(search: [])));

              },
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xffd4d181),
                child: Icon(Icons.shop, size: 17 , color: Colors.black,),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://aarsunwoods.b-cdn.net/wp-content/uploads/2020/03/Wooden-Bedroom-Carved-furniture-in-traditional-style-UH-BED-0047.jpg'),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex:2,
                    child :Container(
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 140, bottom: 10),
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xffd6b738),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(70),
                                      bottomLeft: Radius.circular(70),
                                    )
                                ),
                                child: Center(
                                  child: Text("Anaconda", style: TextStyle(
                                    color: Colors.brown.shade900,
                                    fontSize: 15,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 10,
                                          offset: Offset(3,3)
                                      )
                                    ],

                                  ),),
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text("40 % Off" , style: TextStyle(
                                fontSize: 30 ,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("on all Furniture products" , style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:Container(),
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Double Bed ', style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Search(
                        search: productProvider.DoubleBedDatalist,
                      )));
                    },
                      child: Text(
                        'View All', style: TextStyle(
                          color: Colors.black,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                   children: productProvider.DoubleBedDatalist.map((DoubleData) {
                     return  SingleProduct(
                       ProductId: DoubleData.ProductId,
                       productImage: DoubleData.ProductImage,
                       productName: DoubleData.ProductName ,
                       Price: DoubleData.ProductPrice,
                       onTap: (){
                         Navigator.of(context).push(
                           MaterialPageRoute(
                             builder: (context) => ProductOverview(
                               ProductImage:DoubleData.ProductImage,
                               ProductName: DoubleData.ProductName,
                               ProductPrice: DoubleData.ProductPrice,
                               ProductId: DoubleData.ProductId,
                             ),
                           ),
                         );
                       },
                     );
                   },).toList(),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Single Bed',style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Search(
                          search: productProvider.SingleBedDataList,
                        )));
                      },
                      child: Text(
                        'View All', style: TextStyle(
                          color: Colors.black,fontWeight: FontWeight.bold),))                ],
              ),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.SingleBedDataList.map((SingleBedData) {
                  return  SingleProduct(
                    ProductId: SingleBedData.ProductId,
                    productImage: SingleBedData.ProductImage,
                    productName: SingleBedData.ProductName ,
                    Price: SingleBedData.ProductPrice,
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductOverview(
                            ProductId: SingleBedData.ProductId,
                            ProductImage:SingleBedData.ProductImage,
                            ProductName: SingleBedData.ProductName,
                            ProductPrice: SingleBedData.ProductPrice,
                          ),
                        ),
                      );
                    },
                  );
                },).toList(),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sofa Set',style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Search(
                          search: productProvider.SofaSetDataList,
                        )));
                      },
                      child: Text(
                        'View All', style: TextStyle(
                          color: Colors.black,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.SofaSetDataList.map((SofaSetData) {
                  return  SingleProduct(

                    ProductId: SofaSetData.ProductId,
                    productImage: SofaSetData.ProductImage,
                    productName: SofaSetData.ProductName ,
                    Price: SofaSetData.ProductPrice,
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductOverview(
                            ProductId: SofaSetData.ProductId,
                            ProductImage:SofaSetData.ProductImage,
                            ProductName: SofaSetData.ProductName,
                            ProductPrice: SofaSetData.ProductPrice,
                          ),
                        ),
                      );
                    },
                  );
                },).toList(),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
