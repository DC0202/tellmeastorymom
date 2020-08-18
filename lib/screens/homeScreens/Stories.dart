import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';

class Stories extends StatefulWidget {
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              print("Pressed Submitted Stories View All");
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
