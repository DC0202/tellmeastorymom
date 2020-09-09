import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'screens/SplashScreen.dart';

int initScreen3;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen3 = prefs.getInt("initScreen3");
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage(
          'assets/images/splashScreen.png',
        ),
        context);
    precacheImage(
        AssetImage(
          'assets/images/googleIcon.png',
        ),
        context);
    precacheImage(
        AssetImage(
          'assets/images/profileImage.png',
        ),
        context);
    precacheImage(
        AssetImage(
          'assets/images/shareImage.png',
        ),
        context);

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
      home: SplashScreen(),
    );
  }
}

// List<String> data0 = [
//   "Three little hens",
//   "Love Yourself",
//   "Foolish donkey and the clever fox",
//   "Tini's long hair",
//   "Monkey and a Crocodile",
//   "Siddhartha and the Swan (The Saviour is more potent than the destroyer)",
// ];

// List<String> data1 = [
//   "Three little hens",
//   "Love Yourself",
//   "Foolish donkey and the clever fox",
//   "Tini's long hair",
//   "Monkey and a Crocodile",
//   "Siddhartha and the Swan (The Saviour is more potent than the destroyer)",
// ];

// class DataInsert extends StatefulWidget {
//   @override
//   _DataInsertState createState() => _DataInsertState();
// }

// class _DataInsertState extends State<DataInsert> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {

//         },
//         child: Icon(Icons.ac_unit),
//       ),
//     );
//   }
// }
