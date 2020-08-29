import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/SearchScreen.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/userData.dart';
import 'package:tellmeastorymom/screenSize.dart';
import 'package:tellmeastorymom/screens/homeScreens/Bookmarks.dart';
import 'package:tellmeastorymom/screens/homeScreens/Categories.dart';
import 'package:tellmeastorymom/screens/homeScreens/HomeDrawer.dart';
import 'package:tellmeastorymom/screens/homeScreens/Stories.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  bool isLoading = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        if (value != null) {
          UserData(
            value.data()['displayName'],
            value.data()['email'],
            value.data()['phoneNumber'],
          );
        }
      });
//      await firebaseFirestore
//          .collection("PopularStories")
//          .get()
//          .then((querySnapshot) {
//        querySnapshot.docs.forEach((result) {
//          popularStories.add(StoryData.fromSnapshot(result));
//          // print(result.id);
//          // result.data().map((key, value) => null)
//        });
//      });
      /*StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore
                .collection("PopularStories")
                .where("isLiked", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              likedStories.clear();
              if (snapshot.hasData)
                snapshot.data.documents.forEach((result) {
                  likedStories.add(StoryData.fromSnapshot(result));
                });
              return CommonCardViewScreen(
                storyList: likedStories,
              );
            }),*/
//      await firebaseFirestore
//          .collection("PopularStories")
//          .where("isLatest", isEqualTo: true)
//          .get()
//          .then((querySnapshot) {
//        querySnapshot.docs.forEach((result) {
//          latestStories.add(StoryData.fromSnapshot(result));
//          // print(result.id);
//          // result.data().map((key, value) => null)
//        });
//      });
//      await firebaseFirestore
//          .collection("PopularStories")
//          .where("isRecommended", isEqualTo: true)
//          .get()
//          .then((querySnapshot) {
//        querySnapshot.docs.forEach((result) {
//          recommendedStories.add(StoryData.fromSnapshot(result));
//          // print(result.id);
//          // result.data().map((key, value) => null)
//        });
//      });
//      print(popularStories.length);
//      print(latestStories.length);
//      print(recommendedStories.length);
//      for (var story in popularStories) {
//        print("popularStories " + story.id);
//      }
//      for (var story in latestStories) {
//        print("latestStories " + story.id);
//      }
//      for (var story in recommendedStories) {
//        print("recommendedStories " + story.id);
//      }
      setState(() {
        isLoading = false;
      });
    });
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   await Firebase.initializeApp();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: primaryColour,
          title: Text(
            "Tellmeastorymom",
            style: TextStyle(
              fontFamily: 'Poppins-SemiBold',
              fontSize: 22.0 * ScreenSize.heightMultiplyingFactor,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
            ),
          ),
          bottom: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.5 * ScreenSize.heightMultiplyingFactor,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 15.0 * ScreenSize.heightMultiplyingFactor,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins-Light',
              fontSize: 15.0 * ScreenSize.heightMultiplyingFactor,
            ),
            indicatorPadding: EdgeInsets.only(
                bottom: 10.0 * ScreenSize.heightMultiplyingFactor,
                right: 15.0 * ScreenSize.widthMultiplyingFactor),
            tabs: [
              Tab(text: "Stories"),
              Tab(text: "Categories"),
              Tab(text: "Bookmarks"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              iconSize: 24 * ScreenSize.heightMultiplyingFactor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            )
          ],
        ),
        drawer: HomeDrawer(),
        body: isLoading
            ? circularProgressIndicator()
            : TabBarView(
                controller: tabController,
                children: [
                  Stories(),
                  Categories(),
                  BookMarkScreen(),
                ],
              ),
      ),
    );
  }
}
