import 'package:flutter/material.dart';

const primaryColour = Color(0xFF9224BF);
const physicsForApp = BouncingScrollPhysics();

Widget appBarOverall(
    {String heading, bool searchThere = true, Function() onPressed}) {
  return AppBar(
    backgroundColor: primaryColour,
    title: Text(
      heading,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      ),
    ),
    actions: searchThere
        ? [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: onPressed,
            )
          ]
        : [],
  );
}

Widget circularProgressIndicator({col = primaryColour}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(col),
    ),
  );
}

// const defaultWidth = 411.42857142857144;
const defaultWidth = 375.0;
// const defaultHeight = 774.8571428571429;
const defaultHeight = 812.0;
const defaultSize = Size(defaultWidth, defaultHeight);
