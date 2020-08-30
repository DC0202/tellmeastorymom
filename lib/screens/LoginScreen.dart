import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/phoneNumberScreen.dart';
import 'package:tellmeastorymom/providers/authService.dart';
import 'package:tellmeastorymom/providers/authentication.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
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
  final _textInputKey = GlobalKey<FormFieldState>();
  final greenTick = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String email;
  String password;
  bool _autoValidate = false;
  bool isLoading = false;
  bool isLoadingButton = false;
  bool test2 = false;
  bool test = true;
  TextEditingController phonenumberController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: isLoading
            ? circularProgressIndicator()
            : SingleChildScrollView(
                child: Container(
                  height: size.height * ScreenSize.heightMultiplyingFactor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: 35 * ScreenSize.heightMultiplyingFactor),
                      Text(
                        "Log In",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            fontSize: 26.0 * ScreenSize.heightMultiplyingFactor,
                            fontWeight: FontWeight.bold,
                            color: primaryColour),
                      ),
                      Text(
                        "Access Account",
                        style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                            color: primaryColour),
                      ),
                      SizedBox(
                          height: 50.0 * ScreenSize.heightMultiplyingFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            padding: EdgeInsets.fromLTRB(
                              20.0 * ScreenSize.widthMultiplyingFactor,
                              15.0 * ScreenSize.heightMultiplyingFactor,
                              20.0 * ScreenSize.widthMultiplyingFactor,
                              15.0 * ScreenSize.heightMultiplyingFactor,
                            ),
                            color: Colors.white,
                            elevation: 10.0,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              final FirebaseFirestore firebaseFirestore =
                                  FirebaseFirestore.instance;
                              final FirebaseAuth firebaseAuth =
                                  FirebaseAuth.instance;
                              await AuthService()
                                  .signInWithGoogle()
                                  .then((value) async {
                                if (value[3]) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  if (!value[1]) {
                                    if (value[0]) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                      );
                                    } else {
                                      print(
                                          firebaseAuth.currentUser.phoneNumber);
                                      await firebaseFirestore
                                          .collection('Users')
                                          .doc(firebaseAuth.currentUser.uid)
                                          .set({
                                        'email': firebaseAuth.currentUser.email,
                                        'displayName': firebaseAuth
                                            .currentUser.displayName,
                                        'phoneNumber': firebaseAuth
                                                    .currentUser.phoneNumber ==
                                                null
                                            ? "+91-9876543210"
                                            : firebaseAuth
                                                .currentUser.phoneNumber,
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => firebaseAuth
                                                      .currentUser
                                                      .phoneNumber ==
                                                  null
                                              ? PhoneNumberScreen()
                                              : OnBoardingScreen(),
                                        ),
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                      final snackBar = SnackBar(
                                          content:
                                              Text('Something Went Wrong!'));
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                    scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(value[2]),
                                      duration: Duration(seconds: 3),
                                    ));
                                  }
                                }
                              });
                              setState(() {
                                isLoading = false;
                              });
                              print("signINWithGoogle called");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/googleIcon.png',
                                  width: 32 * ScreenSize.widthMultiplyingFactor,
                                  height:
                                      32 * ScreenSize.heightMultiplyingFactor,
                                ),
                                SizedBox(
                                    width: 10.0 *
                                        ScreenSize.widthMultiplyingFactor),
                                Text(
                                  'Signin With Google',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 16.0 *
                                        ScreenSize.heightMultiplyingFactor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15 * ScreenSize.heightMultiplyingFactor,
                      ),
                      Text(
                        "Or log in with Email",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 12.0 * ScreenSize.heightMultiplyingFactor,
                            color: primaryColour),
                      ),
                      SizedBox(
                        height: 120 * ScreenSize.heightMultiplyingFactor,
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
                                  vertical:
                                      7.5 * ScreenSize.widthMultiplyingFactor),
                              child: TextFormField(
                                key: _textInputKey,
                                controller: phonenumberController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  setState(() {
                                    test =
                                        _textInputKey.currentState.validate();
                                  });
                                },
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
//                                    suffixIcon: test
//                                        ? _textInputKey.currentState == null
//                                            ? Icon(
//                                                Icons.check,
//                                                size: 20 *
//                                                    ScreenSize
//                                                        .heightMultiplyingFactor,
//                                                color: Colors.transparent,
//                                              )
//                                            : Icon(
//                                                Icons.check,
//                                                key: greenTick,
//                                                size: 20 *
//                                                    ScreenSize
//                                                        .heightMultiplyingFactor,
//                                                color: Colors.green,
//                                              )
//                                        : CircularProgressIndicator(
//                                            valueColor:
//                                                AlwaysStoppedAnimation<Color>(
//                                                    Colors.purple),
//                                          ),

//                                        :
//                                    Icon(
//                                            Icons.ac_unit,
//                                            size: 20 *
//                                                ScreenSize
//                                                    .heightMultiplyingFactor,
//                                            color: Colors.red,
//                                          ),
                                    labelText: "Email Address",
                                    labelStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Colors.black54)),
                              ),
                            ),
                            SizedBox(
                              height: 10 * ScreenSize.heightMultiplyingFactor,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      20 * ScreenSize.heightMultiplyingFactor,
                                  vertical:
                                      7.5 * ScreenSize.widthMultiplyingFactor),
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
                                          size: 20 *
                                              ScreenSize
                                                  .heightMultiplyingFactor,
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
                                              ScreenSize
                                                  .heightMultiplyingFactor),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15 * ScreenSize.heightMultiplyingFactor,
                            ),
                            Container(
                              width: 234 * ScreenSize.widthMultiplyingFactor,
                              child: MaterialButton(
                                minWidth:
                                    234 * ScreenSize.widthMultiplyingFactor,
                                height: 45 * ScreenSize.heightMultiplyingFactor,
                                color: Colors.purple,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    setState(() {
                                      isLoadingButton = true;
                                    });
                                    //A network error (such as timeout, interrupted connection or unreachable host) has occurred.
                                    List<dynamic> check =
                                        await Authentication.checkUser(
                                            email, password);
                                    if (check[0] == false) {
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(check[1]),
                                        duration: Duration(seconds: 3),
                                      ));
                                    } else
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                      );
                                    setState(() {
                                      isLoadingButton = false;
                                    });
                                  } else {
                                    setState(() {
                                      _autoValidate = true;
                                    });
                                  }
                                },
                                child: isLoadingButton
                                    ? Container(
                                        margin: EdgeInsets.all(3.0),
                                        height: 25.0 *
                                            ScreenSize.widthMultiplyingFactor,
                                        width: 25.0 *
                                            ScreenSize.widthMultiplyingFactor,
                                        child: circularProgressIndicator(
                                            col: Colors.white))
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 19 *
                                              ScreenSize
                                                  .heightMultiplyingFactor,
                                        ),
                                      ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15 * ScreenSize.heightMultiplyingFactor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Dont have an account?  ",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      15 * ScreenSize.heightMultiplyingFactor,
                                  color: primaryColour)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize:
                                      15 * ScreenSize.heightMultiplyingFactor,
                                  color: primaryColour),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
