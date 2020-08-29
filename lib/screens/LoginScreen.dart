import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/authService.dart';
import 'package:tellmeastorymom/authentication.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/drawerScreens/ShareWithFriends.dart';
import 'package:tellmeastorymom/screenSize.dart';
import 'package:tellmeastorymom/screens/Home.dart';
import 'package:tellmeastorymom/screens/OnBoardingScreen.dart';
import 'package:tellmeastorymom/screens/registerScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _autoValidate = false;
  validateInput() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    setState(() {
      _autoValidate = true;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 35 * ScreenSize.heightMultiplyingFactor),
              Text(
                "Log In",
                style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 40.0 * ScreenSize.heightMultiplyingFactor,
                    fontWeight: FontWeight.bold,
                    color: primaryColour),
              ),
              Text(
                "Access Account",
                style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                    color: primaryColour),
              ),
              SizedBox(height: 70 * ScreenSize.heightMultiplyingFactor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () async {
                      final FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                      await AuthService().signInWithGoogle().then((value) {
                        if (value)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        else {
                          firebaseFirestore
                              .collection('Users')
                              .doc(firebaseAuth.currentUser.uid)
                              .set({
                            'email': firebaseAuth.currentUser.email,
                            'displayName': firebaseAuth.currentUser.displayName,
                            'phoneNumber':
                                firebaseAuth.currentUser.phoneNumber == null
                                    ? "+91-9876543210"
                                    : firebaseAuth.currentUser.phoneNumber,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnBoardingScreen(),
                            ),
                          );
                        }
                      });
                      print("signINWithGoogle called");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/googleIcon.png',
                          width: 65 * ScreenSize.widthMultiplyingFactor,
                          height: 55 * ScreenSize.heightMultiplyingFactor,
                        ),
                        Text(
                          'Signin WIth Google',
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                          ),
                        ),
                      ],
                    ),
                  ),

//                  SizedBox(
//                    width: 18 * ScreenSize.widthMultiplyingFactor,
//                  ),
//                  GestureDetector(
//                      child: Image.asset(
//                        'assets/images/facebookIcon.png',
//                        width: 50 * ScreenSize.widthMultiplyingFactor,
//                        height: 60 * ScreenSize.heightMultiplyingFactor,
//                      ),
//                      onTap: () {}),
//                  SizedBox(
//                    width: 20 * ScreenSize.widthMultiplyingFactor,
//                  ),
//                  GestureDetector(
//                      child: Image.asset(
//                        'assets/Icons/twitterIcon.png',
//                        width: 50 * ScreenSize.widthMultiplyingFactor,
//                        height: 60 * ScreenSize.heightMultiplyingFactor,
//                      ),
//                      onTap: () {}),
//                  SizedBox(
//                    width: 20 * ScreenSize.widthMultiplyingFactor,
//                  ),
//                  GestureDetector(
//                      child: Image.asset(
//                        'assets/Icons/wordPressIcon.png',
//                        width: 60 * ScreenSize.widthMultiplyingFactor,
//                        height: 60 * ScreenSize.heightMultiplyingFactor,
//                      ),
//                      onTap: () {}),
                ],
              ),
              SizedBox(
                height: 15 * ScreenSize.heightMultiplyingFactor,
              ),
              Text(
                "Or log in with Email",
                style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                    color: primaryColour),
              ),
              SizedBox(
                height: 70 * ScreenSize.heightMultiplyingFactor,
              ),
              Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  20 * ScreenSize.heightMultiplyingFactor,
                              vertical: 20 * ScreenSize.widthMultiplyingFactor),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (val) => email = val,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter a Email Address';
                              }
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(val)) {
                                return 'Please enter a valid email Address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.check,
                                  size: 20 * ScreenSize.heightMultiplyingFactor,
                                  color: Colors.black,
                                ),
                                labelText: "Email Address",
                                labelStyle: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.black54)),
                          )),
                      SizedBox(
                        height: 10 * ScreenSize.heightMultiplyingFactor,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * ScreenSize.heightMultiplyingFactor,
                            vertical: 20 * ScreenSize.widthMultiplyingFactor),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val) {
                            if (val.length < 8) {
                              return "Password must be of 8 characters";
                            } else
                              return null;
                          },
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size:
                                        20 * ScreenSize.heightMultiplyingFactor,
                                    color: Colors.black,
                                  ),
                                  onPressed: _toggleVisibility),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  color: Colors.black54)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 15 *
                                        ScreenSize.heightMultiplyingFactor),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15 * ScreenSize.heightMultiplyingFactor,
                      ),
                      RaisedButton(
                          padding: EdgeInsets.only(
                              left: 80 * ScreenSize.widthMultiplyingFactor,
                              right: 80 * ScreenSize.widthMultiplyingFactor,
                              top: 7 * ScreenSize.heightMultiplyingFactor,
                              bottom: 7 * ScreenSize.heightMultiplyingFactor),
                          elevation: 7 * ScreenSize.heightMultiplyingFactor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: primaryColour,
                          onPressed: () async {
                            validateInput();
                            bool check =
                                await Authentication.checkUser(email, password);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    check ? Home() : ShareWithFriends(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                color: Colors.white,
                                fontSize:
                                    25 * ScreenSize.heightMultiplyingFactor),
                          )),
                    ],
                  )),
              SizedBox(
                height: 15 * ScreenSize.heightMultiplyingFactor,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Skip',
                  style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: 17 * ScreenSize.heightMultiplyingFactor),
                ),
              ),
              SizedBox(height: 8 * ScreenSize.heightMultiplyingFactor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Dont have an account?",
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 15 * ScreenSize.heightMultiplyingFactor,
                          color: primaryColour)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        " Register",
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 15 * ScreenSize.heightMultiplyingFactor,
                            color: primaryColour),
                      ))
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
