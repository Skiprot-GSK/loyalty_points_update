import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_points_app/models/product.dart';
import 'package:loyalty_points_app/provider/app_provider.dart';
import 'package:loyalty_points_app/provider/user_provider.dart';
import 'package:loyalty_points_app/screens/cart.dart';
import 'package:loyalty_points_app/widgets/custom_text.dart';
import 'package:loyalty_points_app/widgets/loading.dart';
import 'package:loyalty_points_app/widgets/small_button.dart';
import 'package:loyalty_points_app/widgets/partials.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


import '../widgets/common.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});


  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  double rating = 4;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        leading: BackButton(
          color: darkText,
        ),
        title: Text(widget.product.name, style: h4),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart,color: primaryColor,),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),

        ],
      ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 100, bottom: 100),
                        padding: EdgeInsets.only(top: 100, bottom: 50),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
//                            Image.network(widget.product.image),
                            SizedBox(height: 10,),
                            Text(widget.product.name, style: h5),
                            Text("\R ${widget.product.price / 1}", style: h3),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 20),
                              child: SmoothStarRating(
                                allowHalfRating: false,
                                onRatingChanged: (v) {
                                  setState(() {
                                    rating = v;
                                  });
                                },
                                starCount: 5,
                                rating: rating,
                                size: 27.0,
                                color: Colors.orange,
                                borderColor: Colors.orange,
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Details",style: h4,),

                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child:Center(child: Text(widget.product.description,textAlign: TextAlign.center,style: inputFieldTextStyle,)),),

                                ],),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 25),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text('Quantity', style: h6),
                                    margin: EdgeInsets.only(bottom: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              quantity += 1;
                                            });
                                          },
                                          child: Center(child: Icon(Icons.add)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(quantity.toString(), style: h3),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              if(quantity == 1) return;
                                              quantity -= 1;
                                            });
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 180,
                              child: btnOutline('Buy Now', () {
//                                changeScreen(context,Details());
                              }),
                            ),
                            Container(
                              width: 180,
                              child: btnFlat('Add to Cart', () async {
                              app.changeLoading();
                                print("All set loading");

                                bool value =  await user.addToCard(product: widget.product, quantity: quantity);
                                if(value){
                                  print("Item added to cart");
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("Added to Cart!"))
                                  );
                                  user.reloadUserModel();
                                app.changeLoading();
                                  return;
                                } else{
                                  print("Item NOT added to cart");

                                }
                                print("lOADING SET TO FALSE");
                              }),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .05))
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 160,
                        child: foodItem(widget.product,
                            isProductPage: true,
                            onTapped: () {},
                            imgWidth: 250,
                            onLike: () {}),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
//      body: SafeArea(
//        child: app.isLoading ? Loading() : Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            CircleAvatar(
//              radius: 120,
//              backgroundImage: NetworkImage(widget.product.image),
//            ),
//            SizedBox(height: 15,),
//
//            CustomText(text: widget.product.name,size: 26,weight: FontWeight.bold),
//            CustomText(text: "\$${widget.product.price / 100}",size: 20,weight: FontWeight.w400),
//            SizedBox(height: 10,),
//
//            CustomText(text: "Description",size: 18,weight: FontWeight.w400),
//
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(widget.product.description , textAlign: TextAlign.center, style: TextStyle(color: grey, fontWeight: FontWeight.w300),),
//            ),
//            SizedBox(height: 15,),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: IconButton(icon: Icon(Icons.remove,size: 36,), onPressed: (){
//                    if(quantity != 1){
//                      setState(() {
//                        quantity -= 1;
//                      });
//                    }
//                  }),
//                ),
//
//                GestureDetector(
//                  onTap: ()async{
//                    app.changeLoading();
//                    print("All set loading");
//
//                    bool value =  await user.addToCard(product: widget.product, quantity: quantity);
//                    if(value){
//                      print("Item added to cart");
//                      _key.currentState.showSnackBar(
//                          SnackBar(content: Text("Added ro Cart!"))
//                      );
//                      user.reloadUserModel();
//                      app.changeLoading();
//                      return;
//                    } else{
//                      print("Item NOT added to cart");
//
//                    }
//                    print("lOADING SET TO FALSE");
//
//                  },
//                  child: Container(
//                    decoration: BoxDecoration(
//                        color: primary,
//                        borderRadius: BorderRadius.circular(20)
//                    ),
//                    child: app.isLoading ? Loading() : Padding(
//                      padding: const EdgeInsets.fromLTRB(28,12,28,12),
//                      child: CustomText(text: "Add $quantity To Cart",color: white,size: 22,weight: FontWeight.w300,),
//                    ),
//
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: IconButton(icon: Icon(Icons.add,size: 36,color: red,), onPressed: (){
//                    setState(() {
//                      quantity += 1;
//                    });
//                  }),
//                ),
//              ],
//            ),
//
//          ],
//        ),
//      ),
//    );
  }
}
