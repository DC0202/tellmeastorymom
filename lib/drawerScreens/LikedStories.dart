import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/CommonCardViewScreen.dart';
import 'package:tellmeastorymom/constants/constant.dart';

class LikedStories extends StatefulWidget {
  @override
  _LikedStoriesState createState() => _LikedStoriesState();
}

class _LikedStoriesState extends State<LikedStories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: appBarOverall(
        heading: "Liked Stories",
      ),
      body: CommonCardViewScreen(
        itemCountOfCard: 7,
      ),
    );
  }
}
