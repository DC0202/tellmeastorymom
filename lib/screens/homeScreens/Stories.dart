import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/StoriesScreen.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'package:tellmeastorymom/providers/userData.dart';

class Stories extends StatefulWidget {
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> recents = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.white,
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                    heading: "Popular Stories",
                    itemCount: popularStories.length,
                    storyList: popularStories,
                  ),
                ),
              );
              // print("Pressed Popular Stories View All");
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore
                .collection("Stories")
                .where("isPopular", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              popularStories.clear();
              if (snapshot.hasData) {
                snapshot.data.docs.forEach((result) {
                  popularStories.add(StoryData.fromSnapshot(result));
                });
                return HomeScreenCardView(
                  boxHeight: 445 * ScreenSize.heightMultiplyingFactor,
                  insideHeight: 344 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 245 * ScreenSize.widthMultiplyingFactor,
                  storyList: popularStories,
                  itemCard: true,
                );
              }
              return circularProgressIndicator();
            },
          ),
          RowViewAll(
            heading: "Recently Viewed Stories",
            onpressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                    heading: "Recently Viewed Stories",
                    itemCount: recentlyViewedStories.length,
                    storyList: recentlyViewedStories,
                  ),
                ),
              );
              // print("Pressed Recently Viewed Stories View All");
            },
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: firebaseFirestore
                .collection("Users")
                .doc(UserData.getUserId())
                .snapshots(),
            builder: (context, snapshot) {
              recents.clear();
              if (snapshot.hasData) {
                recents = snapshot.data.data()["recents"] == null
                    ? []
                    : snapshot.data.data()["recents"].cast<String>();
                return StreamBuilder<QuerySnapshot>(
                  stream: firebaseFirestore.collection("Stories").snapshots(),
                  builder: (context, snapshot) {
                    recentlyViewedStories.clear();
                    if (snapshot.hasData) {
                      for (var i = 0; i < recents.length; i++) {
                        snapshot.data.docs.forEach((result) {
                          if (recents[i] == result.id) {
                            recentlyViewedStories
                                .add(StoryData.fromSnapshot(result));
                          }
                        });
                      }

                      return HomeScreenCardView(
                        boxHeight: 210 * ScreenSize.heightMultiplyingFactor,
                        insideHeight: 141 * ScreenSize.heightMultiplyingFactor,
                        insideWidth: 220 * ScreenSize.widthMultiplyingFactor,
                        storyList: recentlyViewedStories,
                        itemCard: true,
                      );
                    }
                    return circularProgressIndicator();
                  },
                );
              }
              return circularProgressIndicator();
            },
          ),
          SizedBox(
            height: 20.0 * ScreenSize.heightMultiplyingFactor,
          ),
          RowViewAll(
            heading: "Recommended Stories",
            onpressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                    heading: "Recommended Stories",
                    itemCount: recommendedStories.length,
                    storyList: recommendedStories,
                  ),
                ),
              );
              // print("Pressed Recommended Stories View All");
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore
                .collection("Stories")
                .where("isRecommended", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              recommendedStories.clear();
              if (snapshot.hasData) {
                snapshot.data.docs.forEach((result) {
                  recommendedStories.add(StoryData.fromSnapshot(result));
                });
                return HomeScreenCardView(
                  boxHeight: 210 * ScreenSize.heightMultiplyingFactor,
                  insideHeight: 141 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 220 * ScreenSize.widthMultiplyingFactor,
                  storyList: recommendedStories,
                  itemCard: true,
                );
              }
              return circularProgressIndicator();
            },
          ),
          SizedBox(
            height: 20.0 * ScreenSize.heightMultiplyingFactor,
          ),
          RowViewAll(
            heading: "Latest Stories",
            onpressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                    heading: "Latest Stories",
                    itemCount: latestStories.length,
                    storyList: latestStories,
                  ),
                ),
              );
              // print("Pressed Latest Stories View All");
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore
                .collection("Stories")
                .where("isLatest", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              latestStories.clear();
              if (snapshot.hasData) {
                snapshot.data.docs.forEach((result) {
                  latestStories.add(StoryData.fromSnapshot(result));
                });
                return HomeScreenCardView(
                  boxHeight: 210 * ScreenSize.heightMultiplyingFactor,
                  insideHeight: 141 * ScreenSize.heightMultiplyingFactor,
                  insideWidth: 220 * ScreenSize.widthMultiplyingFactor,
                  storyList: latestStories,
                  itemCard: true,
                );
              }
              return circularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
