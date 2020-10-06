import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_points_app/models/product.dart';
import 'package:loyalty_points_app/provider/product_provider.dart';
import 'package:loyalty_points_app/provider/user_provider.dart';
import 'package:loyalty_points_app/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/common.dart';
import '../widgets/partials.dart';
import 'custom_text.dart';
import 'loading.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<UserProvider>(context);


    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index) {

            return Padding(
                padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  onTap: () {
                    changeScreen(
                        _,
                        Details(
                          product: productProvider.products[index],
                        ));
                  },
                  child: Container(
                    height: 220,
                    width: 190,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(20)),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Loading(),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Image.network(
                                    productProvider.products[index].image,
                                    height: 120,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: productProvider.products[index].name,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: (){
//                                  setState(() {
//                                    productProvider.products[index].liked = !productProvider.products[index].liked;
//                                  });
//                                  productProvider.likeDislikeProduct(userId: user.userModel.id, product: productProvider.products[index], liked: productProvider.products[index].liked);
                                },
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CustomText(
                                    text: productProvider.products[index].rating
                                        .toString(),
                                    color: grey,
                                    size: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.star,
                                  color: red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: red,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.star,
                                  color: grey,
                                  size: 16,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CustomText(
                                text:
                                "\R ${productProvider.products[index].price / 1}",
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            );
          }),
    );
  }
}
