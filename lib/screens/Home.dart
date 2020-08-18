import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(
          "Tellmeastorymom",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
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
          indicatorWeight: 2.5,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 15.0,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15.0,
          ),
          indicatorPadding: EdgeInsets.only(bottom: 10.0, right: 15.0),
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
