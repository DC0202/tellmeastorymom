import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';

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
            onTap: () {},
            title: Text("Stories"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Categories"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Rate App"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Share with friends"),
          ),
          ListTile(
            onTap: () {},
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}
