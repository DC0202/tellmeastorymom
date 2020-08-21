import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/StoriesScreen.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/drawerScreens/LikedStories.dart';
import 'package:tellmeastorymom/drawerScreens/ShareWithFriends.dart';
import 'package:tellmeastorymom/screens/Home.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(35.0, 35.0, 15.0, 45.0),
            decoration: BoxDecoration(
              color: primaryColour,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 50.0,
                  child: Image.asset(
                    'assets/images/profileImage.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Tellmeastorymom",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Home()));
            },
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StoriesScreen(
                        heading: "Guest Post",
                        itemCount: 16,
                      )));
            },
            leading: Icon(
              Icons.people_outline,
              color: Colors.black,
            ),
            title: Text("Guest posts"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LikedStories()));
            },
            leading: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            title: Text("Liked stories"),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.star_border,
              color: Colors.black,
            ),
            title: Text("Rate App"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ShareWithFriends()));
            },
            leading: Icon(
              Icons.share,
              color: Colors.black,
            ),
            title: Text("Share with friends"),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}
