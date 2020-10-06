import 'package:flutter/material.dart';
// import 'package:flutter_budget_ui/data/data.dart';
import '../helpers/color_helper.dart';
// import 'package:flutter_budget_ui/helpers/color_helper.dart';
import '../models/category_model.dart';
// import 'package:flutter_budget_ui/models/category_model.dart';
import '../models/expense_model.dart';
// import 'package:flutter_budget_ui/models/expense_model.dart';

import '../screens/category_screen.dart';
// import 'package:flutter_budget_ui/screens/category_screen.dart';
import '../widgets/bar_chart.dart';
// import 'package:flutter_budget_ui/widgets/bar_chart.dart';
import '../data/data.dart';
import 'package:loyalty_points_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:loyalty_points_app/widgets/custom_text.dart';
import 'package:loyalty_points_app/widgets/common.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\R${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \R${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;

                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            forceElevated: false,
            floating: true,
            // pinned: true,
            expandedHeight: 80.0,
            leading: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 25.0,
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
//                 title: Align(alignment: Alignment.bottomCenter,child: Text(user.userModel?.name ?? "username lading...",style: TextStyle(color: primaryColor,))),
                ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense) {
                    totalAmountSpent += expense.cost;
                  });
                  return _buildCategory(category, totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          ),
        ],
      ),
    );
  }
}

// // import 'package:flutter/material.dart';

// // class SpendingDetails extends StatefulWidget {
// //   @override
// //   _SpendingDetailsState createState() => _SpendingDetailsState();
// // }

// // class _SpendingDetailsState extends State<SpendingDetails> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "Spending Details",
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: Colors.black87,
// //       ),
// //       body: Center(
// //         child: Text("GRAPHS"),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class SpendingDetails extends StatefulWidget {
//   SpendingDetails({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _SpendingDetailsState createState() => _SpendingDetailsState();
// }

// class _SpendingDetailsState extends State<SpendingDetails> {
//   var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
//   var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

//   List<CircularStackEntry> circularData = <CircularStackEntry>[
//     new CircularStackEntry(
//       <CircularSegmentEntry>[
//         new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
//         new CircularSegmentEntry(1000.0, Color(0xfff3af00), rankKey: 'Q2'),
//         new CircularSegmentEntry(1800.0, Color(0xffec3337), rankKey: 'Q3'),
//         new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
//       ],
//       rankKey: 'Quarterly Profits',
//     ),
//   ];

//   Material myTextItems(String title, String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 30.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Material myCircularItems(String title, String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 30.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: AnimatedCircularChart(
//                       size: const Size(100.0, 100.0),
//                       initialChartData: circularData,
//                       chartType: CircularChartType.Pie,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Material mychart1Items(String title, String priceVal, String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(
//                       priceVal,
//                       style: TextStyle(
//                         fontSize: 30.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueGrey,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: new Sparkline(
//                       data: data,
//                       lineColor: Color(0xffff6101),
//                       pointsMode: PointsMode.all,
//                       pointSize: 8.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Material mychart2Items(String title, String priceVal, String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(
//                       priceVal,
//                       style: TextStyle(
//                         fontSize: 30.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueGrey,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: new Sparkline(
//                       data: data1,
//                       fillMode: FillMode.below,
//                       fillGradient: new LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.amber[800], Colors.amber[200]],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () {
//               //
//             }),
//         // title: Text(widget.title),
//         title: Text("Spending pattern"),
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(FontAwesomeIcons.chartLine),
//               onPressed: () {
//                 //
//               }),
//         ],
//       ),
//       body: Container(
//         color: Color(0xffE5E5E5),
//         child: StaggeredGridView.count(
//           crossAxisCount: 4,
//           crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child:
//                   mychart1Items("Sales by Month", "421.3M", "+12.9% of target"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: myCircularItems("Quarterly Profits", "68.7M"),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: myTextItems("Mktg. Spend", "48.6M"),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: myTextItems("Users", "25.5M"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: mychart2Items("Conversion", "0.9M", "+19% of target"),
//             ),
//           ],
//           staggeredTiles: [
//             StaggeredTile.extent(4, 250.0),
//             StaggeredTile.extent(2, 250.0),
//             StaggeredTile.extent(2, 120.0),
//             StaggeredTile.extent(2, 120.0),
//             StaggeredTile.extent(4, 250.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
