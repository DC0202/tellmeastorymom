import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   await Firebase.initializeApp();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
          )
        ],
      ),
      drawer: HomeDrawer(),
      body: TabBarView(
        controller: tabController,
        children: [
          Stories(),
          Categories(),
          BookMarkScreen(),
        ],
      ),
    );
  }
}
