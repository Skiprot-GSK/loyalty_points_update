import 'package:flutter/material.dart';
import 'package:flutter_rave/flutter_rave.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
    final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
    final _rave = RaveCardPayment(
      isDemo: true,
      encKey: "c53e399709de57d42e2e36ca",
      publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
      transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
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
        Scaffold.of(context).showSnackBar(snackBar_onFailure);
      },
      onClosed: () {
        print("Transaction closed");
        Scaffold.of(context).showSnackBar(snackBar_onClosed);
      },
      context: context,
    );
    _rave.process();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //     centerTitle: true,
    //   ),
    //   body: Center(
    //     child: Builder(
    //       builder: (context) => SingleChildScrollView(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 10.0, right: 10),
    //           child: InkWell(
    //             onTap: () => _pay(context),
    //             child: Card(
    //               color: Colors.orangeAccent,
    //               elevation: 15,
    //               child: Container(
    //                 height: 250,
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Center(
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text(
    //                         "Card Payment",
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 20,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                       SizedBox(
    //                         width: 10,
    //                       ),
    //                       Icon(
    //                         Icons.payment,
    //                         color: Colors.black,
    //                         size: 30,
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  _pay(BuildContext context) {
    final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
    final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
    final _rave = RaveCardPayment(
      isDemo: true,
      encKey: "c53e399709de57d42e2e36ca",
      publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
      transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
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
        Scaffold.of(context).showSnackBar(snackBar_onFailure);
      },
      onClosed: () {
        print("Transaction closed");
        Scaffold.of(context).showSnackBar(snackBar_onClosed);
      },
      context: context,
    );
    _rave.process();
  }
}

// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rave_flutter/rave_flutter.dart';
//
// import 'package:loyalty_points_app/widgets/button_widget.dart';
// import 'package:loyalty_points_app/widgets/switch_widget.dart';
// import 'package:loyalty_points_app/widgets/vendor_widget.dart';
//
//
//
// class HomeWidget extends StatefulWidget {
//   @override
//   _HomeWidgetState createState() => _HomeWidgetState();
// }
//
// class _HomeWidgetState extends State<HomeWidget> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   var formKey = GlobalKey<FormState>();
//   var autoValidate = false;
//   bool acceptCardPayment = true;
//   bool acceptAccountPayment = true;
//   bool acceptMpesaPayment = false;
//   bool shouldDisplayFee = true;
//   bool acceptAchPayments = false;
//   bool acceptGhMMPayments = false;
//   bool acceptUgMMPayments = false;
//   bool acceptMMFrancophonePayments = false;
//   bool live = false;
//   bool preAuthCharge = false;
//   bool addSubAccounts = false;
//   List<SubAccount> subAccounts = [];
//   String email;
//   double amount;
//   String publicKey = "FLWPUBK_TEST-9eae3b8634acbdd9a801947fc50358c5-X";
//   String encryptionKey = "FLWSECK_TEST433cb384db13";
//   String txRef;
//   String orderRef;
//   String narration;
//   String currency;
//   String country;
//   String firstName;
//   String lastName;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       body: SafeArea(
//         top: true,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: Column(
//               children: <Widget>[
//                 SwitchWidget(
//                   value: acceptCardPayment,
//                   title: 'Accept card payments',
//                   onChanged: (value) =>
//                       setState(() => acceptCardPayment = value),
//                 ),
//                 SwitchWidget(
//                   value: acceptAccountPayment,
//                   title: 'Accept account payments',
//                   onChanged: (value) =>
//                       setState(() => acceptAccountPayment = value),
//                 ),
//                 SwitchWidget(
//                   value: acceptMpesaPayment,
//                   title: 'Accept Mpesa payments',
//                   onChanged: (value) =>
//                       setState(() => acceptMpesaPayment = value),
//                 ),
//                 SwitchWidget(
//                   value: shouldDisplayFee,
//                   title: 'Should Display Fee',
//                   onChanged: (value) =>
//                       setState(() => shouldDisplayFee = value),
//                 ),
//                 SwitchWidget(
//                   value: acceptAchPayments,
//                   title: 'Accept ACH payments',
//                   onChanged: (value) =>
//                       setState(() => acceptAchPayments = value),
//                 ),
//                 SwitchWidget(
//                   value: acceptGhMMPayments,
//                   title: 'Accept GH Mobile money payments',
//                   onChanged: (value) =>
//                       setState(() => acceptGhMMPayments = value),
//                 ),
//                 SwitchWidget(
//                   value: acceptUgMMPayments,
//                   title: 'Accept UG Mobile money payments',
//                   onChanged: (value) =>
//                       setState(() => acceptUgMMPayments = value),
//                 ),
//                 SwitchWidget(
//                   value: acceptMMFrancophonePayments,
//                   title: 'Accept Mobile money Francophone Africa payments',
//                   onChanged: (value) =>
//                       setState(() => acceptMMFrancophonePayments = value),
//                 ),
//                 SwitchWidget(
//                   value: live,
//                   title: 'Live',
//                   onChanged: (value) => setState(() => live = value),
//                 ),
//                 SwitchWidget(
//                   value: preAuthCharge,
//                   title: 'Pre Auth Charge',
//                   onChanged: (value) => setState(() => preAuthCharge = value),
//                 ),
//                 SwitchWidget(
//                     value: addSubAccounts,
//                     title: 'Add subaccounts',
//                     onChanged: onAddAccountsChange),
//                 buildVendorRefs(),
//                 Padding(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Form(
//                     key: formKey,
//                     autovalidate: autoValidate,
//                     child: Column(
//                       children: <Widget>[
//                         TextFormField(
//                           decoration: InputDecoration(hintText: 'Email'),
//                           onSaved: (value) => email = value,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration:
//                           InputDecoration(hintText: 'Amount to charge'),
//                           onSaved: (value) => amount = double.tryParse(value),
//                           keyboardType: TextInputType.number,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration: InputDecoration(hintText: 'txRef'),
//                           onSaved: (value) => txRef = value,
//                           initialValue:
//                           "rave_flutter-${DateTime.now().toString()}",
//                           validator: (value) =>
//                           value.trim().isEmpty ? 'Field is required' : null,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration: InputDecoration(hintText: 'orderRef'),
//                           onSaved: (value) => orderRef = value,
//                           initialValue:
//                           "rave_flutter-${DateTime.now().toString()}",
//                           validator: (value) =>
//                           value.trim().isEmpty ? 'Field is required' : null,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration: InputDecoration(hintText: 'Narration'),
//                           onSaved: (value) => narration = value,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               hintText: 'Currency code e.g NGN'),
//                           onSaved: (value) => currency = value,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration:
//                           InputDecoration(hintText: 'Country code e.g NG'),
//                           onSaved: (value) => country = value,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration: InputDecoration(hintText: 'First name'),
//                           onSaved: (value) => firstName = value,
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           decoration: InputDecoration(hintText: 'Last name'),
//                           onSaved: (value) => lastName = value,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Button(text: 'Start Payment', onPressed: validateInputs)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildVendorRefs() {
//     if (!addSubAccounts) {
//       return SizedBox();
//     }
//
//     addSubAccount() async {
//       var subAccount = await showDialog<SubAccount>(
//           context: context, builder: (context) => AddVendorWidget());
//       if (subAccount != null) {
//         if (subAccounts == null) subAccounts = [];
//         setState(() => subAccounts.add(subAccount));
//       }
//     }
//
//     var buttons = <Widget>[
//       Button(
//         onPressed: addSubAccount,
//         text: 'Add vendor',
//       ),
//       SizedBox(
//         width: 10,
//         height: 10,
//       ),
//       Button(
//         onPressed: () => onAddAccountsChange(false),
//         text: 'Clear',
//       ),
//     ];
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Your current vendor refs are: ${subAccounts.map((a) => '${a.id}(${a.transactionSplitRatio})').join(', ')}',
//             textAlign: TextAlign.center,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Platform.isIOS
//                 ? Column(
//               children: buttons,
//             )
//                 : Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: buttons,
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   onAddAccountsChange(bool value) {
//     setState(() {
//       addSubAccounts = value;
//       if (!value) {
//         subAccounts.clear();
//       }
//     });
//   }
//
//   void validateInputs() {
//     var formState = formKey.currentState;
//     if (!formState.validate()) {
//       setState(() => autoValidate = true);
//       return;
//     }
//
//     formState.save();
//     startPayment();
//   }
//
//   void startPayment() async {
//     var initializer = RavePayInitializer(
//         amount: amount,
//         publicKey: publicKey,
//         encryptionKey: encryptionKey,
//         subAccounts: subAccounts.isEmpty ? null : null)
//       ..country =
//       country = country != null && country.isNotEmpty ? country : "NG"
//       ..currency = currency != null && currency.isNotEmpty ? currency : "NGN"
//       ..email = email
//       ..fName = firstName
//       ..lName = lastName
//       ..narration = narration ?? ''
//       ..txRef = txRef
//       ..orderRef = orderRef
//       ..acceptMpesaPayments = acceptMpesaPayment
//       ..acceptAccountPayments = acceptAccountPayment
//       ..acceptCardPayments = acceptCardPayment
//       ..acceptAchPayments = acceptAchPayments
//       ..acceptGHMobileMoneyPayments = acceptGhMMPayments
//       ..acceptUgMobileMoneyPayments = acceptUgMMPayments
//       ..acceptMobileMoneyFrancophoneAfricaPayments = acceptMMFrancophonePayments
//       ..displayEmail = false
//       ..displayAmount = false
//       ..staging = !live
//       ..isPreAuth = preAuthCharge
//       ..displayFee = shouldDisplayFee;
//
//     var response = await RavePayManager()
//         .prompt(context: context, initializer: initializer);
//     print(response);
//     scaffoldKey.currentState
//         .showSnackBar(SnackBar(content: Text(response?.message)));
//   }
// }