
import 'package:loyalty_points_app/provider/app_provider.dart';
import 'package:loyalty_points_app/provider/user_provider.dart';
import 'package:loyalty_points_app/provider/product_provider.dart';
import 'package:loyalty_points_app/provider/category_provider.dart';
import 'package:loyalty_points_app/screens/product_details.dart';
import 'package:loyalty_points_app/screens/category.dart';
import 'package:loyalty_points_app/screens/cart.dart';
import 'package:loyalty_points_app/screens/SpendingDetails.dart';
import 'package:loyalty_points_app/widgets/custom_app_bar.dart';
import 'package:loyalty_points_app/widgets/featured_products.dart';
import 'package:loyalty_points_app/widgets/featuerd_prods.dart';
import 'package:loyalty_points_app/widgets/product_card.dart';
import 'package:loyalty_points_app/widgets/common.dart';
import 'package:loyalty_points_app/widgets/custom_text.dart';
import 'package:loyalty_points_app/widgets/search.dart';
import 'package:loyalty_points_app/widgets/categories.dart';
import 'package:loyalty_points_app/screens/payment.dart';
import 'package:loyalty_points_app/helpers/fryo_icons.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_points_app/screens/login.dart';
import 'package:loyalty_points_app/widgets/loading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              accountName: CustomText(
                text: user.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, AccountScreen());
              },
              leading: Icon(Icons.person),
              title: CustomText(text: "Account"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),

            ListTile(
              onTap: () async{
                await user.getOrders();
               // changeScreen(context, HomeWidget());
              },
              leading: Icon(Icons.payment),
              title: CustomText(text: "Make Payments"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, Login());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      )
          : SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.only(right: 50.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (pattern)async{
//                        app.changeLoading();
                        if(app.search == SearchBy.PRODUCTS){
                          await productProvider.search(productName: pattern);
//                          changeScreen(context, ProductSearchScreen());
                        }else{
//                          await restaurantProvider.search(name: pattern);
//                          changeScreen(context, RestaurantsSearchScreen());
                        }
                        app.changeLoading();
                      },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    fillColor: white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8, color: highlightColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: "What are you looking for",
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, size: 25.0),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            headerTopCategories(),
            SizedBox(
              height: 10,
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Text('For you', style: h4),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 2),
              child: FlatButton(
                onPressed: (){},
                child: Text('See all ›', style: contrastText),
              ),
            )
          ],
        ),
            Container(
              height: 250,
                color: Colors.black12,
                child: Featured()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Text('Groceries', style: h4),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 2),
            child: FlatButton(
              onPressed: (){},
              child: Text('See all ›', style: contrastText),
            ),
          )
        ],
      ),
            Container(
                height: 250,
                child: Featured()),
          ],
        ),
      ),
    );
  }
}

Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
          child: Text('See all ›', style: contrastText),
        ),
      )
    ],
  );
}
Widget headerTopCategories() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      sectionHeader('Categories', onViewMore: () {}),
      SizedBox(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            headerCategoryItem('Groceries', Fryo.shop, onPressed: () {}),
            headerCategoryItem('Clothing', Fryo.shirt, onPressed: () {}),
            headerCategoryItem('Electronics', Fryo.camera, onPressed: () {}),
            headerCategoryItem('Cosmetics', Fryo.pencil, onPressed: () {}),
            headerCategoryItem('Fresh Produce', Fryo.leaf, onPressed: () {}),
          ],
        ),
      )
    ],
  );
}

Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 65,
            height: 65,
            child: FloatingActionButton(
              elevation: 0.0,
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Icon(icon, size: 30, color: Colors.black87),
            )),
        Text(name, style: categoryText)
      ],
    ),
  );
}

