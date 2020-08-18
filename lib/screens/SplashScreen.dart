import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/screens/Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              left: 58.0,
              top: 244.0,
              child: Container(
                // color: Colors.blue,
                width: size.width * 0.7,
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
                              fontSize: 18.0,
                              height: 0.9,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          TextSpan(
                            text: "me a\n",
                            style: TextStyle(
                              fontSize: 28.0,
                              height: 0.7,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          TextSpan(
                            text: "Story\n",
                            style: TextStyle(
                              fontSize: 90.0,
                              height: 0.95,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF8151),
                            ),
                          ),
                          TextSpan(
                            text: "mom",
                            style: TextStyle(
                              fontSize: 35.0,
                              height: 0.6,
                              fontWeight: FontWeight.w100,
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
    );
  }
}
