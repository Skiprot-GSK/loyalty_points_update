import 'package:flutter/material.dart';
//import '../shared/styles.dart';
import '../widgets/common.dart';
import '../widgets/small_button.dart';

import 'package:page_transition/page_transition.dart';
import './signup.dart';
import './login.dart';

class PageScreen extends StatefulWidget {
  final String pageTitle;

  PageScreen({Key key, this.pageTitle}) : super(key: key);

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/coin.png', width: 190, height: 190),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 0),
                child: Text('Coin!', style: logoStyle),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.only(bottom: 0),
                child: btnFlat('Sign In', () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.rotate,
                          duration: Duration(seconds: 1),
                          child: Login()));
                }),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(0),
                child: btnOutline('Sign Up', () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.rotate,
                          duration: Duration(seconds: 1),
                          child: SignUp()));
                  // Navigator.of(context).pushReplacementNamed('/signup');
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Langauage:', style: TextStyle(color: darkText)),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      child: Text('English ›',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              )
            ],
          )),
      backgroundColor: bgColor,
    );
  }
}
