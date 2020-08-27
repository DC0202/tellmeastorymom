import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/storyData.dart';

import '../screenSize.dart';
import 'CommonCardViewScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchData = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<StoryData> popularStories = [];
  String textSearch = 'some loreal epsum';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: primaryColour,
          title: Container(
            height: 35.0,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                hintText: "Search a story ...",
              ),
              // keyboardType: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  if (value == "") {
                    textSearch = "99";
                  } else {
                    textSearch = value;
                  }
                });
                print(value);
              },
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore.collection("PopularStories").snapshots(),
          builder: (context, snapshot) {
            popularStories.clear();
            if (snapshot.hasData)
              snapshot.data.docs.forEach((result) {
                print(result.data());
                if (StoryData.fromSnapshot(result)
                    .title
                    .toLowerCase()
                    .contains(textSearch)) {
                  popularStories.add(StoryData.fromSnapshot(result));
                }
              });
            print(popularStories.toString());

            return popularStories.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/noStories.png',
                          height: 243 * ScreenSize.heightMultiplyingFactor,
                          width: 243 * ScreenSize.widthMultiplyingFactor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0 * ScreenSize.heightMultiplyingFactor,
                          ),
                          child: Text(
                            "No Stories to display!!",
                            style: TextStyle(
                              fontSize:
                                  18.0 * ScreenSize.heightMultiplyingFactor,
                              fontFamily: 'Poppins-SemiBold',
                              color: primaryColour,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : CommonCardViewScreen(
                    storyList: popularStories,
                  );
          },
        ),
      ),
    );
  }
}
