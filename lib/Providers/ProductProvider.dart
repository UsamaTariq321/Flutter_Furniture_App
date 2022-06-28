import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/ProductModel.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel>  DoubleBedData = [];
  List<ProductModel> SingleBedData =[];
  List<ProductModel> SofaSetData =[];
  late ProductModel productModel;
  List<ProductModel> search = [];

  ProductModels(QueryDocumentSnapshot snapshot){
    productModel = ProductModel(
        snapshot.get('ProductName'),
        snapshot.get('ProductImage'),
        snapshot.get('ProductPrice'),
        snapshot.get('ProductId'),

    );
    search.add(productModel);
  }


  fetchDoubleBed() async{
    List<ProductModel>  NewList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Product_DoubleBed").get();

    snapshot.docs.forEach((element) {
      ProductModels(element);
      NewList.add(productModel);
    });

    DoubleBedData=NewList;
    print(DoubleBedData);
    notifyListeners();

  }

  fetchSingleBed() async{
    List<ProductModel>  NewList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Product_SingleBed").get();

    snapshot.docs.forEach((element) {
      ProductModels(element);
      NewList.add(productModel);
    });

    SingleBedData=NewList;
    print(SingleBedData);
    notifyListeners();

  }


  fetchSofaSet() async{
    List<ProductModel>  NewList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Sofa_Set").get();

    snapshot.docs.forEach((element) {
      ProductModels(element);
      NewList.add(productModel);
    });

    SofaSetData=NewList;
    print(SofaSetData);
    notifyListeners();

  }

  List <ProductModel> get DoubleBedDatalist{
    return DoubleBedData;
  }

  List <ProductModel> get SingleBedDataList{
    return SingleBedData;
  }
  List <ProductModel> get SofaSetDataList{
    return SofaSetData;
  }
  List <ProductModel> get SearchAllProduct{
    return search;
  }
}