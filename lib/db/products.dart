import 'dart:async';
import 'package:loyalty_points_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService{
  Firestore _firestore = Firestore.instance;
  String collection = 'products';

  Future<List<ProductModel>> getFeaturedProducts() =>
      _firestore.collection(collection).getDocuments().then((snap){
        List<ProductModel> featuredProducts = [];
        snap.documents.map((snapshot) => featuredProducts.add(ProductModel.fromSnapshot(snapshot)));
        return featuredProducts;
      });
}