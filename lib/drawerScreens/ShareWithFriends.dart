import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';

class ShareWithFriends extends StatefulWidget {
  @override
  _ShareWithFriendsState createState() => _ShareWithFriendsState();
}

class _ShareWithFriendsState extends State<ShareWithFriends> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarOverall(heading: "Share with friends", searchThere: false),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  child: Image.asset(
                    'assets/images/shareImage.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Invite your friends to read &\nenjoy amazing stories",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Container(
              width: 234.0,
              padding: EdgeInsets.all(15.0),
              child: RaisedButton(
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {},
                color: Color(0xFF1492E6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Share App",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
