import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
import 'package:tellmeastorymom/screens/OnBoardingScreen.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height * ScreenSize.heightMultiplyingFactor,
          width: size.width * ScreenSize.widthMultiplyingFactor,
          padding: EdgeInsets.fromLTRB(
            10.0 * ScreenSize.widthMultiplyingFactor,
            60.0 * ScreenSize.heightMultiplyingFactor,
            10.0 * ScreenSize.widthMultiplyingFactor,
            30.0 * ScreenSize.heightMultiplyingFactor,
          ),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter Phone Number",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 26.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: 25.0 * ScreenSize.heightMultiplyingFactor,
              ),
              TextField(
                autofocus: true,
                cursorColor: primaryColour,
                decoration: InputDecoration(
                    labelText: "Phone-Number",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: primaryColour,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: primaryColour,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: primaryColour,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    prefixText: "+91- "),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              // SizedBox(
              //   height: 250.0 * ScreenSize.heightMultiplyingFactor,
              // ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 275.0 * ScreenSize.widthMultiplyingFactor,
                    child: Text(
                      "By clicking next you agree to all the terms and policy of Tellmeastorymom. The details are going to be confidential to yourself and you wont be expecting any mischief with it. Hope you enjoy reading story!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0 * ScreenSize.heightMultiplyingFactor,
                        fontFamily: "Poppins-Regular",
                      ),
                    ),
                  ),
                  OutlineButton(
                    onPressed: () {
                      final FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      firebaseFirestore
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .update({
                        'phoneNumber': phoneNumber,
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnBoardingScreen(),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: primaryColour,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    highlightedBorderColor: primaryColour,
                    splashColor: primaryColour.withOpacity(0.1),
                    borderSide: BorderSide(
                      color: primaryColour,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: primaryColour,
                        fontFamily: "Poppins-SemiBold",
                        fontSize: 16.0 * ScreenSize.heightMultiplyingFactor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
