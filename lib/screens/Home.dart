import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/SearchScreen.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/userData.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
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
            FirebaseAuth.instance.currentUser.uid,
            value.data()['displayName'],
            value.data()['email'],
            value.data()['phoneNumber'],
          );
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

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
              iconSize: 35 * ScreenSize.heightMultiplyingFactor,
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
