import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'package:tellmeastorymom/screenSize.dart';

import 'Readings.dart';

class HomeScreenCardView extends StatefulWidget {
  final double boxHeight;
  final double insideHeight;
  final double insideWidth;
  final bool itemCard;
  const HomeScreenCardView(
      {Key key,
      this.boxHeight,
      this.insideHeight,
      this.storyList,
      this.insideWidth,
      this.itemCard = false})
      : super(key: key);

  final List<StoryData> storyList;

  @override
  _HomeScreenCardViewState createState() => _HomeScreenCardViewState();
}

class _HomeScreenCardViewState extends State<HomeScreenCardView> {
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: size.width,
      height: widget.boxHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: physicsForApp,
        itemCount: widget.storyList.length < 3 ? widget.storyList.length : 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // ),
              print(index);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Readings(widget.storyList[index]),
              ));
            },
            child: Container(
              margin: EdgeInsets.only(
                  right: 15.0 * ScreenSize.widthMultiplyingFactor,
                  left: index == 0
                      ? 15.0 * ScreenSize.widthMultiplyingFactor
                      : 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: widget.insideHeight,
                        width: widget.insideWidth,
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
                            image: widget.itemCard
                                ? AssetImage(
                                    'assets/images/cardImage.jpg',
                                  )
                                : AssetImage(
                                    'assets/images/smallCardImage.jpg',
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0 * ScreenSize.heightMultiplyingFactor,
                          horizontal: 8.0 * ScreenSize.widthMultiplyingFactor,
                        ),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    5.0 * ScreenSize.heightMultiplyingFactor,
                                horizontal:
                                    5.0 * ScreenSize.widthMultiplyingFactor,
                              ),
                              child: GestureDetector(
                                // focusColor: Colors.white.withOpacity(0.8),
                                child: Icon(
                                  widget.storyList[index].isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: widget.storyList[index].isBookmarked
                                      ? primaryColour
                                      : Colors.black,
                                  size: 24 * ScreenSize.heightMultiplyingFactor,
                                ),
                                onTap: () {
//                                  print(
//                                    "Widget Index" + index.toString(),
//                                  );
                                  setState(() {
                                    widget.storyList[index].isBookmarked =
                                        !widget.storyList[index].isBookmarked;
                                  });
                                  firebaseFirestore
                                      .collection("PopularStories")
                                      .doc(widget.storyList[index].id)
                                      .update({
                                    "isBookmarked":
                                        widget.storyList[index].isBookmarked
                                  });
                                },
                              ),
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
//                    "Little red riding hood",
                    widget.storyList[index].title,
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 12.0 * ScreenSize.heightMultiplyingFactor,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.storyList[index].author,
//                    "By tellmeastorymom",
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 9.0 * ScreenSize.heightMultiplyingFactor,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 5.0 * ScreenSize.heightMultiplyingFactor,
                  ),
                  Wrap(
                    spacing: 5.0 * ScreenSize.widthMultiplyingFactor,
                    // runSpacing: 7.0,
                    children: List<Widget>.generate(
                      widget.storyList[index].related.length,
                      (int i) {
                        return Container(
                          height: 25.0 * ScreenSize.heightMultiplyingFactor,
                          padding: EdgeInsets.fromLTRB(
                            10.0 * ScreenSize.widthMultiplyingFactor,
                            5.0 * ScreenSize.heightMultiplyingFactor,
                            10.0 * ScreenSize.widthMultiplyingFactor,
                            5.0 * ScreenSize.heightMultiplyingFactor,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: colorList[i],
                          ),
                          child: Center(
                            child: Text(
                              widget.storyList[index].related[i],
//                              "Folklore",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize:
                                    10.0 * ScreenSize.heightMultiplyingFactor,
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
