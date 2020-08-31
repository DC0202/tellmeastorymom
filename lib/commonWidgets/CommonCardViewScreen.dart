import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
import 'package:tellmeastorymom/providers/userData.dart';

import 'Readings.dart';

class CommonCardViewScreen extends StatefulWidget {
//  final int itemCountOfCard;
//  final bool bookmark;
  final List<StoryData> storyList;

  const CommonCardViewScreen({Key key, this.storyList}) : super(key: key);
  @override
  _CommonCardViewScreenState createState() => _CommonCardViewScreenState();
}

class _CommonCardViewScreenState extends State<CommonCardViewScreen> {
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
    Color(0xFF6D60F8)
  ];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.white,
      height: size.height,
      padding: EdgeInsets.only(
          left: 20.0 * ScreenSize.widthMultiplyingFactor,
          right: 20.0 * ScreenSize.widthMultiplyingFactor),
      child: widget.storyList.length == 0
          ? Column(
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
                      fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                      fontFamily: 'Poppins-SemiBold',
                      color: primaryColour,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              physics: physicsForApp,
              itemCount: widget.storyList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Readings(widget.storyList[index]),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 15.0 * ScreenSize.heightMultiplyingFactor,
                        bottom: 15.0 * ScreenSize.heightMultiplyingFactor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height:
                                  180.0 * ScreenSize.heightMultiplyingFactor,
                              width: 375.0 * ScreenSize.widthMultiplyingFactor,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 6.0,
                                    offset: Offset(0, 3),
                                    color: Colors.black.withOpacity(0.16),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/cardImage.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      8.0 * ScreenSize.widthMultiplyingFactor,
                                  vertical:
                                      8.0 * ScreenSize.heightMultiplyingFactor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white.withOpacity(0.8),
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: IconButton(
                                  //     // focusColor: Colors.white.withOpacity(0.8),
                                  //     icon: Icon(Icons.record_voice_over),
                                  //     onPressed: () {
                                  //       print(
                                  //         "Widget Index" + index.toString(),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 10.0,
                                  // ),

                                  StreamBuilder(
                                    stream: firebaseFirestore
                                        .collection("PopularStories")
                                        .doc(widget.storyList[index].id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<String> isBookmarked = [];
                                      if (snapshot.hasData) {
                                        isBookmarked = snapshot.data
                                                    .data()["isBookmarked"] ==
                                                null
                                            ? []
                                            : snapshot.data
                                                .data()["isBookmarked"]
                                                .cast<String>();
                                      }
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.0 *
                                                ScreenSize
                                                    .widthMultiplyingFactor,
                                            vertical: 3.0 *
                                                ScreenSize
                                                    .heightMultiplyingFactor),
                                        child: GestureDetector(
                                          child: Icon(
                                            isBookmarked.contains(
                                                    UserData.getUserId())
                                                ? Icons.bookmark
                                                : Icons.bookmark_border,
                                            color: isBookmarked.contains(
                                                    UserData.getUserId())
                                                ? primaryColour
                                                : Colors.black,
                                            size: 35 *
                                                ScreenSize
                                                    .heightMultiplyingFactor,
                                          ),
                                          onTap: () {
                                            bool valueOfList = isBookmarked
                                                .contains(UserData.getUserId());
                                            if (valueOfList) {
                                              firebaseFirestore
                                                  .collection("PopularStories")
                                                  .doc(widget
                                                      .storyList[index].id)
                                                  .update({
                                                "isBookmarked":
                                                    FieldValue.arrayRemove(
                                                        [UserData.getUserId()])
                                              });
                                            } else {
                                              firebaseFirestore
                                                  .collection("PopularStories")
                                                  .doc(widget
                                                      .storyList[index].id)
                                                  .update({
                                                "isBookmarked":
                                                    FieldValue.arrayUnion(
                                                        [UserData.getUserId()])
                                              });
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 6.0 * ScreenSize.heightMultiplyingFactor,
                        ),
                        Text(
                          widget.storyList[index].title,
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.storyList[index].author,
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 11.0 * ScreenSize.heightMultiplyingFactor,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 5.0 * ScreenSize.heightMultiplyingFactor,
                        ),
                        Wrap(
                          spacing: 5.0 * ScreenSize.widthMultiplyingFactor,
                          children: List<Widget>.generate(
                            widget.storyList[index].related.length < 4
                                ? widget.storyList[index].related.length
                                : 4,
                            (int i) {
                              return Container(
                                height:
                                    25.0 * ScreenSize.heightMultiplyingFactor,
                                width: 70.0 * ScreenSize.widthMultiplyingFactor,
                                padding: EdgeInsets.fromLTRB(
                                  10.0 * ScreenSize.widthMultiplyingFactor,
                                  5.0 * ScreenSize.heightMultiplyingFactor,
                                  10.0 * ScreenSize.widthMultiplyingFactor,
                                  5.0 * ScreenSize.heightMultiplyingFactor,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: colorList[i % colorList.length],
                                ),
                                child: Center(
                                  child: Text(
                                    widget.storyList[index].related[i],
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 10.0 *
                                          ScreenSize.heightMultiplyingFactor,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
