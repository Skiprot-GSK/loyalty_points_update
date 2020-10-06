import 'package:loyalty_points_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loyalty_points_app/screens/login.dart';
import 'package:flutter/material.dart';


class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text('Santos Enoque'),
              accountEmail: Text('santosenoque.ss@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.red.shade900
              ),
            ),

//            body

            InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
               Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),

//            InkWell(
//              onTap: (){},
//              child: ListTile(
//                title: Text('Categoris'),
//                leading: Icon(Icons.dashboard),
//              ),
//            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
              ),
            ),

          ],
        ),
      );
  }
}
