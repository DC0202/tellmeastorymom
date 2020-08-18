import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';

import 'CommonCardViewScreen.dart';

class StoriesScreen extends StatefulWidget {
  final String heading;
  final int itemCount;

  const StoriesScreen({Key key, this.heading, this.itemCount})
      : super(key: key);
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOverall(heading: widget.heading),
      body: CommonCardViewScreen(
        itemCountOfCard: widget.itemCount,
      ),
    );
  }
}
