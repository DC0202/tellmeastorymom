import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/SearchScreen.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
import 'package:tellmeastorymom/drawerScreens/mompreneurScreens/ListBuilder.dart';
import 'package:tellmeastorymom/providers/storyData.dart';

class Mompreneur extends StatefulWidget {
  @override
  _MompreneurState createState() => _MompreneurState();
}

class _MompreneurState extends State<Mompreneur> with SingleTickerProviderStateMixin {
  TabController tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(
          "Mompreneur",
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
          indicatorPadding: EdgeInsets.only(bottom: 10.0 * ScreenSize.heightMultiplyingFactor, right: 15.0 * ScreenSize.widthMultiplyingFactor),
          tabs: [
            Tab(text: "Interviews"),
            Tab(text: "Diary"),
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
      body: isLoading
          ? circularProgressIndicator()
          : TabBarView(
              controller: tabController,
              children: [
                // Interview(),
                ListBuilder(
                  storyList: popularStories,
                ),
                // Diary(),
                ListBuilder(
                  storyList: popularStories,
                  isDiary: true,
                ),
              ],
            ),
    );
  }
}
