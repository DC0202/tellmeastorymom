import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            aboutUsAppBar(),
            Positioned(
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
                          child: Image.asset(
                            "assets/images/about_us.png",
                            height: 248 * ScreenSize.heightMultiplyingFactor,
                            width: 206 * ScreenSize.widthMultiplyingFactor,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            AboutUsData(),
          ],
        ),
      ),
    );
  }
}

class AboutUsData extends StatelessWidget {
  const AboutUsData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 450 * ScreenSize.heightMultiplyingFactor,
        ),
        Container(
            padding: EdgeInsets.all(20 * ScreenSize.heightMultiplyingFactor),
            child: Text(
              "We aim to provide a platform to those parents who "
              "find it difficult to curate stories for their little ones. "
              "We're using groundbreaking technology to set stories free into"
              " a world of unbridled possibility.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20 * ScreenSize.heightMultiplyingFactor,
                fontFamily: 'Poppins-Light',
              ),
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}

Widget aboutUsAppBar() {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(221.0 * ScreenSize.heightMultiplyingFactor),
      child: appBarOverall(heading: 'About Us', searchThere: false),
    ),
  );
}
