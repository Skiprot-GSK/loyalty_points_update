import 'package:flutter/material.dart';
import './screens/login.dart';
import './screens/signup.dart';
import './screens/hello.dart';
import './screens/home.dart';
import './screens/details.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import './screens/OnBoardingPage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:loyalty_points_app/provider/app_provider.dart';
import 'package:loyalty_points_app/provider/product_provider.dart';
import './widgets/loading.dart';
import 'package:provider/provider.dart';
import './provider/user_provider.dart';
import './provider/category_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coin',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: ScreensController(),
        routes: <String, WidgetBuilder>{
          '/onBoarding': (BuildContext context) => OnBoardingPage(),
          // '/homePage': (BuildContext context) => HomePage(pageTitle: 'Welcome'),
          '/signup': (BuildContext context) => SignUp(),
          '/signin': (BuildContext context) => Login(),
          '/dashboard': (BuildContext context) => HomePage(),
          '/productPage': (BuildContext context) => Details(),
        },
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return SplashScreen();
      default:
        return SignUp();
//    https://github.com/Skiprot-GSK/Coin-Master.git
    }
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/onBoarding');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('images/coin.png', width: 190, height: 190),
      ),
    );
  }
}
