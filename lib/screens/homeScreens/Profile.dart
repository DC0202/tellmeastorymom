import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/screenSize.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // appBarOverall(heading: 'Profile'),
          profilePageAppBar(),
          profileDataList(),
        ],
      ),
    );
  }
}

Widget profilePageAppBar() {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize:
          Size.fromHeight(221.0 * ScreenSize.heightMultiplyingFactor),
      child: appBarOverall(heading: 'Profile', searchThere: false),
    ),
  );
}

Widget profileDataList(
    {String userName = 'UserName',
    String userEmail = 'user@email',
    String userPhone = '+91-9876543210',
    String userImageAsset = 'assets/images/profileImage.png'}) {
  print('width' +
      (ScreenSize.pwidth * ScreenSize.widthMultiplyingFactor).toString());
  return Positioned(
    top: 135.0 * ScreenSize.heightMultiplyingFactor,
    left: 1,
    right: 1,
    child: Center(
      child: Column(
        children: [
          Container(
            width: 335.0 * ScreenSize.widthMultiplyingFactor,
            height: 262.0 * ScreenSize.heightMultiplyingFactor,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              elevation: 3.0 * ScreenSize.heightMultiplyingFactor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 50.0,
                    child: Image.asset(
                      userImageAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 335.0 * ScreenSize.widthMultiplyingFactor,
            height: 44.2 * ScreenSize.heightMultiplyingFactor,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0 * ScreenSize.widthMultiplyingFactor,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: primaryColour,
                    ),
                    SizedBox(
                      width: 15.0 * ScreenSize.widthMultiplyingFactor,
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16.0 * ScreenSize.heightMultiplyingFactor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 335.0 * ScreenSize.widthMultiplyingFactor,
            height: 44.2 * ScreenSize.heightMultiplyingFactor,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0 * ScreenSize.widthMultiplyingFactor,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      //required outline icon not found in the list
                      color: primaryColour,
                    ),
                    SizedBox(
                      width: 15.0 * ScreenSize.widthMultiplyingFactor,
                    ),
                    Text(
                      userPhone,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16.0 * ScreenSize.heightMultiplyingFactor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
