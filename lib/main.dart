import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'screens/SplashScreen.dart';

// var routes= <String, WidgetBuilder>{
//   "/login":(BuildContext context)=>LoginPage(),
//   "/signup":(BuildContext context)=>SignUpPage(),

//   "/home_oe":(BuildContext context)=>HomeOE(),
//   // "/viewpage_oe":(BuildContext context)=>ViewOE(),
//   "/payment_history_oe":(BuildContext context)=>PaymentHistoryOE(),
//   "/user_details_oe":(BuildContext context)=>UserDetailsOE(),
// };

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1.0, alwaysUse24HourFormat: false),
            child: child,
          );
        },
        theme: ThemeData(
          primaryColor: Color(0xFF0F2985),
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
