import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_points_app/models/category.dart';
import 'package:loyalty_points_app/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/common.dart';
import 'custom_text.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 145.0,
        child: ListTile(
          title:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 82.0,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(50.0)
              ),
              child: ClipOval(
                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: category.image,fit: BoxFit.cover,),//this is the logon is stored
              ),
            ),
          ),
          subtitle: Container(
            alignment: Alignment.topCenter,
            child: Text(category.name),// Where caption is stored
          ),
        ),
      ),
    );
//    return Padding(
//      padding: const EdgeInsets.all(6),
//      child: Stack(
//        children: <Widget>[
//          Container(
//            width: 140,
//            height: 160,
//            child: ClipRRect(
//                borderRadius: BorderRadius.circular(30),
//                child: Stack(
//                  children: <Widget>[
//                    Positioned.fill(child: Align(
//                      alignment: Alignment.center,
//                      child: Loading(),
//                    )),
//                    Center(
//                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: category.image),
//                    )
//                  ],
//                )),
//          ),
//
//          Container(
//            width: 140,
//            height: 160,
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.only(
//                  bottomLeft: Radius.circular(30),
//                  bottomRight: Radius.circular(30),
//                ),
//                gradient: LinearGradient(
//                  begin: Alignment.bottomCenter,
//                  end: Alignment.topCenter,
//                  colors: [
//                    Colors.black.withOpacity(0.6),
//                    Colors.black.withOpacity(0.6),
//                    Colors.black.withOpacity(0.6),
//                    Colors.black.withOpacity(0.4),
//                    Colors.black.withOpacity(0.1),
//                    Colors.black.withOpacity(0.05),
//                    Colors.black.withOpacity(0.025),
//                  ],
//                )),
//          ),
//
//          Positioned.fill(
//              child: Align(
//                  alignment: Alignment.center,
//                  child: CustomText(text: category.name, color: white, size: 26, weight: FontWeight.w300,)))
//        ],
//      ),
//    );
  }
}
