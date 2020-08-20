import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/StoriesScreen.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';

import 'Readings.dart';

class Stories extends StatefulWidget {
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    return Container(
      width: size.width,
      child: ListView(
        physics: physicsForApp,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 21.0,
          ),
          RowViewAll(
            heading: "Popular Stories",
            onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                        heading: "Popular Stories",
                        itemCount: 4,
                      )));
              print("Pressed Popular Stories View All");
            },
          ),
          HomeScreenCardView(
            boxHeight: 445,
            insideHeight: 344,
            insideWidth: 245,
            itemCountOfCard: 3,
            itemCard: true,
          ),
          RowViewAll(
            heading: "Ongoing Stories",
            onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                        heading: "Ongoing Stories",
                        itemCount: 2,
                      )));
              print("Pressed Ongoing Stories View All");
            },
          ),
          HomeScreenCardView(
            boxHeight: 210.0,
            insideWidth: 220.0,
            insideHeight: 141.0,
            itemCountOfCard: 4,
          ),
          RowViewAll(
            heading: "Recommended Stories",
            onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                        heading: "Recommended Stories",
                        itemCount: 10,
                      )));
              print("Pressed Recommended Stories View All");
            },
          ),
          HomeScreenCardView(
            boxHeight: 210.0,
            insideWidth: 220.0,
            insideHeight: 141.0,
            itemCountOfCard: 4,
          ),
          RowViewAll(
            heading: "Latest Stories",
            onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                        heading: "Latest Stories",
                        itemCount: 6,
                      )));
              print("Pressed Latest Stories View All");
            },
          ),
          HomeScreenCardView(
            boxHeight: 210.0,
            insideWidth: 220.0,
            insideHeight: 141.0,
            itemCountOfCard: 4,
          ),
          RowViewAll(
            heading: "Submitted Stories",
            onpressed: () {
//              Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context) => StoriesScreen(
//                        heading: "Submitted Stories",
//                        itemCount: 20,
//                      )));
//              print("Pressed Submitted Stories View All");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Readings(),
              ));
            },
          ),
          HomeScreenCardView(
            boxHeight: 210.0,
            insideWidth: 220.0,
            insideHeight: 141.0,
            itemCountOfCard: 4,
          ),
        ],
      ),
    );
  }
}
