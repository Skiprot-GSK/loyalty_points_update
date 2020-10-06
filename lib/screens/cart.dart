import 'package:flutter/material.dart';
import 'package:loyalty_points_app/helpers/order.dart';
import 'package:loyalty_points_app/widgets/common.dart';
import 'package:loyalty_points_app/models/product.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../provider/app_provider.dart';
import 'package:loyalty_points_app/widgets/custom_text.dart';
import 'package:loyalty_points_app/widgets/loading.dart';
import 'package:loyalty_points_app/screens/payment.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_rave/flutter_rave.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
    final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
    final _rave = RaveCardPayment(
      isDemo: true,
      encKey: "FLWSECK_TEST433cb384db13",
      publicKey: "FLWPUBK_TEST-9eae3b8634acbdd9a801947fc50358c5-X",
      transactionRef: "SCH${DateTime.now().millisecondsSinceEpoch}",
      amount: user.userModel.totalCartPrice / 01,
      email: "demo1@example.com",
      onSuccess: (response) {
        print("$response");
        print("Transaction Successful");
        if (mounted) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Transaction Sucessful!"),
              backgroundColor: Colors.green,
              duration: Duration(
                seconds: 5,
              ),
            ),
          );
        }
      },
      onFailure: (err) {
        print("$err");
        print("Transaction failed");
        _key.currentState.showSnackBar(snackBar_onFailure);
      },
      onClosed: () {
        print("Transaction closed");
        _key.currentState.showSnackBar(snackBar_onClosed);

        // Navigator.pop(context);
      },
      context: context,

    );

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: app.isLoading ? Loading() : ListView.builder(
          itemCount: user.userModel.cart.length,
          itemBuilder: (_, index) {
            print("THE PRICE IS: ${user.userModel.cart[index]["price"]}");
            print("THE QUANTITY IS: ${user.userModel.cart[index]["quantity"]}");

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red.withOpacity(0.2),
                          offset: Offset(3, 2),
                          blurRadius: 30)
                    ]),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        user.userModel.cart[index]["image"],
                        height: 120,
                        width: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: user.userModel.cart[index]["name"] + "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\R${user.userModel.cart[index]["price"] / 01} \n\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: "Quantity: ",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: user.userModel.cart[index]["quantity"].toString(),
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: red,
                              ),
                              onPressed: ()async{
                                app.changeLoading();
                                bool value = await user.removeFromCart(cartItem: user.userModel.cart[index]);
                                if(value){
                                  user.reloadUserModel();
                                  print("Item added to cart");
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("Removed from Cart!"))
                                  );
                                  app.changeLoading();
                                  return;
                                }else{
                                  print("ITEM WAS NOT REMOVED");
                                  app.changeLoading();
                                }
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: " \R${user.userModel.totalCartPrice / 01}",
                      style: TextStyle(
                          color: primary,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: primary),
                child: FlatButton(
                    onPressed: () {
                      if(user.userModel.totalCartPrice == 0){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Your cart is empty', textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('You will be charged \R${user.userModel.totalCartPrice / 01} upon delivery!', textAlign: TextAlign.center,),

                                      InkWell(
                                        // onTap: () => _pay(context),
                                        child: SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () async{

                                              var uuid = Uuid();
                                              String id = uuid.v4();
                                              _orderServices.createOrder(
                                                  userId: user.user.uid,
                                                  id: id,
                                                  description: "Some random description",
                                                  status: "complete",
                                                  totalPrice: user.userModel.totalCartPrice,
                                                  cart: user.userModel.cart
                                              );
                                              // _pay(context);
                                              _rave.process();
                                              for(Map cartItem in user.userModel.cart){
                                                bool value = await user.removeFromCart(cartItem: cartItem);
                                                if(value){

                                                  user.reloadUserModel();
                                                  print("Item added to cart");
                                                  _key.currentState.showSnackBar(
                                                      SnackBar(content: Text("Removed from Cart!"))
                                                  );
                                                }else{
                                                  print("ITEM WAS NOT REMOVED");
                                                }
                                              }

                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Text("Order created!"))
                                              );

                                              Navigator.pop(context);
                                              // changeScreenReplacement(context, PaymentPage());

                                            },
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            color: red
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Check out",
                      size: 20,
                      color: white,
                       weight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
     _pay(BuildContext context) {
     final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
     final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
     final _rave = RaveCardPayment(
       isDemo: true,
       encKey: "FLWSECK_TEST433cb384db13",
       publicKey: "FLWPUBK_TEST-9eae3b8634acbdd9a801947fc50358c5-X",
       transactionRef: "SCH${DateTime.now().millisecondsSinceEpoch}",
       amount: 100,
       email: "demo1@example.com",
       onSuccess: (response) {
         print("$response");
         print("Transaction Successful");
         if (mounted) {
           Scaffold.of(context).showSnackBar(
             SnackBar(
               content: Text("Transaction Sucessful!"),
               backgroundColor: Colors.green,
               duration: Duration(
                 seconds: 5,
              ),
             ),
           );
         }
       },
       onFailure: (err) {
         print("$err");
         print("Transaction failed");
         _key.currentState.showSnackBar(snackBar_onFailure);
       },
       onClosed: () {
         print("Transaction closed");
         _key.currentState.showSnackBar(snackBar_onClosed);

         // Navigator.pop(context);
       },
       context: context,

     );
     _rave.process();
   }
}
