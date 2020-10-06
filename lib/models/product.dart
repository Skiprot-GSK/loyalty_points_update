import 'package:cloud_firestore/cloud_firestore.dart';

//class Product{
//  static const ID = "id";
//  static const CATEGORY = "category";
//  static const NAME = "name";
//  static const PRICE = "price";
//  static const BRAND = "brand";
//  static const COLORS = "colors";
//  static const QUANTITY = "quantity";
//  static const SIZES = "sizes";
//  static const SALE = "sale";
//  static const FEATURED = "featured";
//  static const PICTURE = "picture";
//
//
//  String _id;
//  String _name;
//  String _brand;
//  String _category;
//  String _picture;
//  double _price;
//  int _quantity;
//  List _colors;
//  List _sizes;
//  bool _onSale;
//  bool _featured;
//
////  getters
//  String get name => _name;
//  String get id => _id;
//  String get category => _category;
//  String get brand => _brand;
//  String get picture => _picture;
//  double get price => _price;
//  int get quantity => _quantity;
//  List get colors => _colors;
//  List get sizes => _sizes;
//  bool get onSale => _onSale;
//  bool get featured => _featured;
//
////  named constructure
//  Product.fromSnapshot(DocumentSnapshot snapshot){
//    Map data = snapshot.data;
//    _name = data[NAME];
//    _id = data[NAME];
//    _category = data[NAME];
//    _brand = data[BRAND];
//    _price = data[PRICE];
//    _quantity = data[QUANTITY];
//    _colors = data[COLORS];
//    _onSale = data[SALE];
//    _featured = data[FEATURED];
//    _picture = data[PICTURE];
//  }
//
//}
class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const RESTAURANT = "restaurant";
  static const USERLIKED = "userLiked";
  static const DISCOUNT = "discount";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";


  String _id;
  String _name;
//  int _restaurantId;
//  String _restaurant;
  int _discount;
  bool _userLiked;
  String _category;
  String _image;
  String _description;

  double _rating;
  int _price;
  int _rates;

  bool _featured;

  String get id => _id;

  String get name => _name;

//  String get restaurant => _restaurant;
//
//  int get restaurantId => _restaurantId;
  bool get userLiked => _userLiked;

  int get discount => _discount;

  String get category => _category;

  String get description => _description;

  String get image => _image;

  double get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  int get rates => _rates;

  // public variable
  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
//    _restaurant = snapshot.data[RESTAURANT];
//    _restaurantId = snapshot.data[RESTAURANT_ID];
    _userLiked = snapshot.data[RESTAURANT];
    _discount = snapshot.data[RESTAURANT_ID];
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE];
    _category = snapshot.data[CATEGORY];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _name = snapshot.data[NAME];
  }
}
