import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tellmeastorymom/authentication.dart';
import 'package:tellmeastorymom/drawerScreens/ShareWithFriends.dart';
import 'package:tellmeastorymom/screenSize.dart';
import 'package:tellmeastorymom/screens/OnBoardingScreen.dart';

import '../constants/constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showNormalPassword = false;
  bool showConfirmPassword = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String userName;
  String phoneNumber;
  String email;
  String password;
  bool _autoValidate = false;
  validateInput() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
    }
    setState(() {
      _autoValidate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height:
                      (size.height * 0.2) * ScreenSize.heightMultiplyingFactor,
                  width: size.width * ScreenSize.widthMultiplyingFactor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                            color: primaryColour,
                            fontSize: 25 * ScreenSize.heightMultiplyingFactor,
                            fontFamily: "Poppins-SemiBold"),
                      ),
                      Text(
                        "Let's Create account First",
                        style: TextStyle(
                          color: primaryColour,
                          fontFamily: "Poppins-Medium",
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formkey,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onSaved: (val) {
                            userName = val;
                          },
                          validator: (val) {
                            if (val.length < 3) {
                              return " Username is too short";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              size: 20 * ScreenSize.heightMultiplyingFactor,
                              color: Colors.black,
                            ),
                            labelText: "User name",
                            labelStyle: TextStyle(
                              fontFamily: "Poppins-Regular",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (val) {
                            if (val.length < 10) {
                              return "Invalid Contact";
                            } else
                              return null;
                          },
                          onSaved: (val) => phoneNumber = val,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixText: "+91-",
                            labelStyle: TextStyle(
                              fontFamily: "Poppins-Regular",
                            ),
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.black,
                              size: 20 * ScreenSize.heightMultiplyingFactor,
                            ),
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onSaved: (val) => email = val,
                          validator: (val) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val);
                            if (emailValid) {
                              return null;
                            } else
                              return "Invalid Email";
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: "Poppins-Regular",
                            ),
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.black,
                              size: 20 * ScreenSize.heightMultiplyingFactor,
                            ),
                            labelText: "Email Address",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          onSaved: (val) {
                            password = val;
                          },
                          validator: (val) {
                            if (val.length < 8) {
                              return "Password must be of 8 character";
                            } else
                              return null;
                          },
                          obscureText: !showNormalPassword,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: "Poppins-Regular",
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                showNormalPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20 * ScreenSize.heightMultiplyingFactor,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  showNormalPassword = !showNormalPassword;
                                });
                              },
                            ),
                            labelText: "Password",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val == password) {
                              return null;
                            } else
                              return "Password is different";
                          },
                          obscureText: !showConfirmPassword,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: "Poppins-Regular",
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20 * ScreenSize.heightMultiplyingFactor,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  showConfirmPassword = !showConfirmPassword;
                                });
                              },
                            ),
                            labelText: "Confirm Password",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60 * ScreenSize.heightMultiplyingFactor,
                      ),
                      MaterialButton(
                        minWidth: 200 * ScreenSize.widthMultiplyingFactor,
                        height: 45 * ScreenSize.heightMultiplyingFactor,
                        color: Colors.purple,
                        onPressed: () async {
                          validateInput();
                          bool check = await Authentication.createUser(
                              email, password, userName, phoneNumber);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => check
                                  ? OnBoardingScreen()
                                  : ShareWithFriends(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18 * ScreenSize.heightMultiplyingFactor,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40 * ScreenSize.heightMultiplyingFactor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                          color: primaryColour, fontFamily: "Poppins-Regular"),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: primaryColour,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
