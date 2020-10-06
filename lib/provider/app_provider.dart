import 'package:loyalty_points_app/db/products.dart';
import 'package:loyalty_points_app/models/product.dart';
import 'package:flutter/material.dart';

enum SearchBy{PRODUCTS, RESTAURANTS}

class AppProvider with ChangeNotifier{
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  String filterBy = "Products";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}){
    search = newSearchBy;
    if(newSearchBy == SearchBy.PRODUCTS){
      filterBy = "Products";
    }else{
      filterBy = "Restaurants";
    }
    notifyListeners();
  }

  addPrice({int newPrice}){
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({int newQuantity}){
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice(){
    print("THE TOTAL SUM IS: $priceSum");
    print("THE TOTAL SUM IS: $priceSum");
    print("THE TOTAL SUM IS: $priceSum");
    print("THE TOTAL SUM IS: $priceSum");
    print("THE QUANTITY SUM IS: $quantitySum");
    print("THE QUANTITY SUM IS: $quantitySum");
    print("THE QUANTITY SUM IS: $quantitySum");
    print("THE QUANTITY SUM IS: $quantitySum");


    totalPrice = priceSum * quantitySum;
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");
    print("THE TOTAL AMOUNT IS: $totalPrice");



    notifyListeners();
  }
//class AppProvider with ChangeNotifier {
//  List<Product> _featureProducts = [];
//  ProductsService _productsService = ProductsService();
//
//  AppProvider() {
//    _getFeaturedProducts();
//  }
//
////  getter
//  List<Product> get featureProducts => _featureProducts;
//
////  methods
//  void _getFeaturedProducts() async {
//    _featureProducts = await _productsService.getFeaturedProducts();
//    notifyListeners();
//  }
}
