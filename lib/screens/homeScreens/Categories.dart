// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import '../../constants/constant.dart';

// class Categories extends StatefulWidget {
//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//   List<String> imageList = [
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(12),
//       child: new StaggeredGridView.countBuilder(
//           physics: physicsForApp,
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           itemCount: imageList.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(Radius.circular(12))),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(12)),
//                   child: FadeInImage.memoryNetwork(
//                     placeholder: kTransparentImage,
//                     image: imageList[index],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//           },
//           staggeredTileBuilder: (index) {
//             return new StaggeredTile.count(1, index.isOdd ? 1.1 : 1.1);
//           }),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/screenSize.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // double widthValue() {
  //   var val = Random().nextInt(320);
  // }

  List<Color> col = [
    Color(0xFFDF5D90),
    Color(0xFFFFC687),
    Color(0xFF2D73D5),
    Color(0xFFFF9870),
    Color(0xFF6D60F8),
    Color(0xFF68E0E0),
    Color(0xFF1492E6),
    Color(0xFFF39358),
    Color(0xFF69DFA6),
    Color(0xFF9D8DFF),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
          10.0 * ScreenSize.widthMultiplyingFactor,
          10.0 * ScreenSize.heightMultiplyingFactor,
          10.0 * ScreenSize.widthMultiplyingFactor,
          0.0 * ScreenSize.heightMultiplyingFactor),
      child: ListView.builder(
        itemCount: 20,
        scrollDirection: Axis.vertical,
        physics: physicsForApp,
        itemBuilder: (context, index) {
          var val = Random();
//          print(index);
          // while (val.toDouble() < 80.0 && val.toDouble() > 220.0) {
          //   val = Random().nextInt(80-220);
          // }

          int next(int min, int max) => min + val.nextInt(max - min + 50);
          var value = next(120, 180);
          print(value);
          return Container(
            padding: EdgeInsets.only(
                top: 10.0 * ScreenSize.heightMultiplyingFactor,
                bottom: 10.0 * ScreenSize.heightMultiplyingFactor,
                left: 7.5 * ScreenSize.widthMultiplyingFactor,
                right: 7.5 * ScreenSize.widthMultiplyingFactor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
//                    color: Color(0xFFFEE546),
                    color: col[((2 * index) % col.length)],
                  ),
                  width: value.toDouble(),
                  height: 141.0 * ScreenSize.heightMultiplyingFactor,
                  child: Center(
                    child: Container(
                      width: value.toDouble() - 10.0,
                      child: Text(
                        "0 - 3 Years Old knowledge",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          color: Colors.white,
                          fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 17.5 * ScreenSize.widthMultiplyingFactor,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 5.0 * ScreenSize.widthMultiplyingFactor,
                          right: 5.0 * ScreenSize.widthMultiplyingFactor,
                        ),
//                        width: value.toDouble() - 10.0,
                        child: Text(
                          "Mumma made stories",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            color: Colors.white,
                            fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
//                      color: Colors.black,
                      color: col[((2 * index) + 1) % col.length],
                    ),
//                    width: (340.0 - value),
                    height: 141.0 * ScreenSize.heightMultiplyingFactor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
