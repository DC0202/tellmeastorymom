import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/StoriesScreen.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'package:tellmeastorymom/screenSize.dart';

class Stories extends StatefulWidget {
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  bool isLoading = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      await firebaseFirestore
          .collection("PopularStories")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          popularStories.add(StoryData.fromSnapshot(result));
          // print(result.id);
          // result.data().map((key, value) => null)
        });
      });

      print(popularStories[0].id);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? circularProgressIndicator()
        : Container(
            width: size.width,
            padding: EdgeInsets.only(
                top: 15.0 * ScreenSize.heightMultiplyingFactor,
                bottom: 5.0 * ScreenSize.heightMultiplyingFactor),
            child: ListView(
              physics: physicsForApp,
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(
                  height: 21.0 * ScreenSize.heightMultiplyingFactor,
                ),
                RowViewAll(
                  heading: "Popular Stories",
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StoriesScreen(
                              heading: "Popular Stories",
                              itemCount: popularStories.length,
                              storyList: popularStories,
                            )));
                    print("Pressed Popular Stories View All");
                  },
                ),
                HomeScreenCardView(
                  boxHeight: 445 * ScreenSize.heightMultiplyingFactor,
                  insideHeight: 344 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 245 * ScreenSize.widthMultiplyingFactor,
                  itemCountOfCard: 3,
                  itemCard: true,
                ),
                RowViewAll(
                  heading: "Ongoing Stories",
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StoriesScreen(
                              heading: "Ongoing Stories",
                              itemCount: 0,
                            )));
                    print("Pressed Ongoing Stories View All");
                  },
                ),
                HomeScreenCardView(
                  boxHeight: 210.0 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 220.0 * ScreenSize.widthMultiplyingFactor,
                  insideHeight: 141.0 * ScreenSize.heightMultiplyingFactor,
                  itemCountOfCard: 4,
                ),
                SizedBox(
                  height: 20.0 * ScreenSize.heightMultiplyingFactor,
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
                  boxHeight: 210.0 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 220.0 * ScreenSize.widthMultiplyingFactor,
                  insideHeight: 141.0 * ScreenSize.heightMultiplyingFactor,
                  itemCountOfCard: 4,
                ),
                SizedBox(
                  height: 20.0 * ScreenSize.heightMultiplyingFactor,
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
                  boxHeight: 210.0 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 220.0 * ScreenSize.widthMultiplyingFactor,
                  insideHeight: 141.0 * ScreenSize.heightMultiplyingFactor,
                  itemCountOfCard: 4,
                ),
              ],
            ),
          );
  }
}
