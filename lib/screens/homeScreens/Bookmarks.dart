import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/CommonCardViewScreen.dart';
import 'package:tellmeastorymom/providers/storyData.dart';

class BookMarkScreen extends StatefulWidget {
  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseFirestore
          .collection("PopularStories")
          .where("isBookmarked", isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        bookmarkedStories.clear();
        if (snapshot.hasData)
          snapshot.data.docs.forEach((result) {
            bookmarkedStories.add(StoryData.fromSnapshot(result));
          });
        return CommonCardViewScreen(
          storyList: bookmarkedStories,
        );
      },
    );
  }
}
