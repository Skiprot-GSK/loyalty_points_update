import 'dart:async';

import 'package:loyalty_points_app/db/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loyalty_points_app/helpers/order.dart';
import 'package:loyalty_points_app/models/order.dart';
import 'package:loyalty_points_app/models/product.dart';
import 'package:loyalty_points_app/models/user.dart';

//enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}
//
//class UserProvider with ChangeNotifier{
//  FirebaseAuth _auth;
//  FirebaseUser _user;
//  Status _status = Status.Uninitialized;
//  Status get status => _status;
//  FirebaseUser get user => _user;
//  Firestore _firestore = Firestore.instance;
//  UserServices _userServices = UserServices();
//  OrderServices _orderServices = OrderServices();
//  UserModel _userModel;
//
//  UserProvider.initialize(): _auth = FirebaseAuth.instance{
//    _auth.onAuthStateChanged.listen(_onStateChanged);
//  }
//
//  Future<bool> signIn(String email, String password)async{
//    try{
//      _status = Status.Authenticating;
//      notifyListeners();
//      await _auth.signInWithEmailAndPassword(email: email, password: password);
//      return true;
//    }catch(e){
//      _status = Status.Unauthenticated;
//      notifyListeners();
//      print(e.toString());
//      return false;
//    }
//  }
//
//
//  Future<bool> signUp(String name,String email, String password)async{
//    try{
//      _status = Status.Authenticating;
//      notifyListeners();
//      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
////        _firestore.collection('users').document(user.uid).setData({
////          'name':name,
////          'email':email,
////          'uid':user.uid
////        });
//      Map<String, dynamic> values ={
//        'name':name,
//        'email':email,
//        'uid':user.uid
//      };
//        _userServices.createUser(values);
//      });
//      return true;
//    }catch(e){
//      _status = Status.Unauthenticated;
//      notifyListeners();
//      print(e.toString());
//      return false;
//    }
//  }
//
//  Future signOut()async{
//    _auth.signOut();
//    _status = Status.Unauthenticated;
//    notifyListeners();
//    return Future.delayed(Duration.zero);
//  }
//
//
//
//  Future<void> _onStateChanged(FirebaseUser user) async{
//    if(user == null){
//      _status = Status.Unauthenticated;
//    }else{
//      _user = user;
//      _status = Status.Authenticated;
//    }
//    notifyListeners();
//  }
//}
import 'package:uuid/uuid.dart';


enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServicse = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;

  // public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();


  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
        _firestore.collection('users').document(result.user.uid).setData({
          'name':name.text,
          'email':email.text,
          'uid':result.user.uid,
          "likedFood": [],
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController(){
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel()async{
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }


  Future<void> _onStateChanged(FirebaseUser firebaseUser) async{
    if(firebaseUser == null){
      _status = Status.Unauthenticated;
    }else{
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel product, int quantity})async{
    print("THE PRODUCT IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");

    try{
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
//      bool itemExists = false;
      Map cartItem ={
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

//      for(Map item in cart){
//        if(item["productId"] == cartItem["productId"]){
////          call increment quantity
//          itemExists = true;
//          break;
//        }
//      }

//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServicse.addToCart(userId: _user.uid, cartItem: cartItem);
//      }



      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }

  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({Map cartItem})async{
    print("THE PRODUCT IS: ${cartItem.toString()}");

    try{
      _userServicse.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }
}