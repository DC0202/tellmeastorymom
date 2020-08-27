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
      child: widget.storyList.length == 0
          ? circularProgressIndicator()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: physicsForApp,
              itemCount:
                  widget.storyList.length < 3 ? widget.storyList.length : 3,
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
                                vertical:
                                    8.0 * ScreenSize.heightMultiplyingFactor,
                                horizontal:
                                    8.0 * ScreenSize.widthMultiplyingFactor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 3.0 *
                                          ScreenSize.heightMultiplyingFactor,
                                      horizontal: 3.0 *
                                          ScreenSize.widthMultiplyingFactor,
                                    ),
                                    child: GestureDetector(
                                      child: Icon(
                                        widget.storyList[index].isBookmarked
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color:
                                            widget.storyList[index].isBookmarked
                                                ? primaryColour
                                                : Colors.black,
                                        size: 24 *
                                            ScreenSize.heightMultiplyingFactor,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          widget.storyList[index].isBookmarked =
                                              !widget.storyList[index]
                                                  .isBookmarked;
                                        });
                                        firebaseFirestore
                                            .collection("PopularStories")
                                            .doc(widget.storyList[index].id)
                                            .update({
                                          "isBookmarked": widget
                                              .storyList[index].isBookmarked
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
                          widget.storyList[index].title,
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 12.0 * ScreenSize.heightMultiplyingFactor,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.storyList[index].author,
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
                          children: List<Widget>.generate(
                            widget.storyList[index].related.length,
                            (int i) {
                              return Container(
                                height:
                                    25.0 * ScreenSize.heightMultiplyingFactor,
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
