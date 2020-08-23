import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tellmeastorymom/screenSize.dart';
import 'package:tellmeastorymom/screens/OnBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size.width,
                child: Image.asset(
                  'assets/images/splashScreen.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: 58.0 * ScreenSize.widthMultiplyingFactor,
                top: 244.0 * ScreenSize.heightMultiplyingFactor,
                child: Container(
                  // color: Colors.blue,
                  width: size.width * 0.75 * ScreenSize.widthMultiplyingFactor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "tell\n",
                              style: TextStyle(
                                fontFamily: 'Poppins-Thin',
                                fontSize:
                                    18.0 * ScreenSize.heightMultiplyingFactor,
                                height: 0.9,
                              ),
                            ),
                            TextSpan(
                              text: "me a\n",
                              style: TextStyle(
                                fontFamily: 'Poppins-Thin',
                                fontSize:
                                    25.0 * ScreenSize.heightMultiplyingFactor,
                                height: 0.7,
                              ),
                            ),
                            TextSpan(
                              text: "Story\n",
                              style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize:
                                    84.0 * ScreenSize.heightMultiplyingFactor,
                                height: 1.0,
                                color: Color(0xFFFF8151),
                              ),
                            ),
                            TextSpan(
                              text: "mom",
                              style: TextStyle(
                                fontFamily: 'Poppins-Thin',
                                fontSize:
                                    35.0 * ScreenSize.heightMultiplyingFactor,
                                height: 0.175,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
