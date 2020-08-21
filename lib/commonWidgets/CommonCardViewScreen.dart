import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/screenSize.dart';

import 'Readings.dart';

class CommonCardViewScreen extends StatefulWidget {
  final int itemCountOfCard;
  final bool bookmark;

  const CommonCardViewScreen(
      {Key key, this.itemCountOfCard, this.bookmark = false})
      : super(key: key);
  @override
  _CommonCardViewScreenState createState() => _CommonCardViewScreenState();
}

class _CommonCardViewScreenState extends State<CommonCardViewScreen> {
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width,
      height: size.height,
      padding: EdgeInsets.only(
          left: 20.0 * ScreenSize.widthMultiplyingFactor,
          right: 20.0 * ScreenSize.widthMultiplyingFactor),
      // margin: EdgeInsets.only(top: 10.0, left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: physicsForApp,
        itemCount: widget.itemCountOfCard,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Readings(),
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
                        height: 180.0 * ScreenSize.heightMultiplyingFactor,
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
                            horizontal: 8.0 * ScreenSize.widthMultiplyingFactor,
                            vertical: 8.0 * ScreenSize.heightMultiplyingFactor),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      5.0 * ScreenSize.widthMultiplyingFactor,
                                  vertical:
                                      5.0 * ScreenSize.heightMultiplyingFactor),
                              child: GestureDetector(
                                // focusColor: Colors.white.withOpacity(0.8),
                                child: Icon(
                                  widget.bookmark
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: widget.bookmark
                                      ? primaryColour
                                      : Colors.black,
                                  size: 24 * ScreenSize.heightMultiplyingFactor,
                                ),
                                onTap: () {
                                  print(
                                    "Widget Index" + index.toString(),
                                  );
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
                    "Little red riding hood",
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "By tellmeastorymom",
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
                    // runSpacing: 7.0,
                    children: List<Widget>.generate(
                      3,
                      (int i) {
                        return Container(
                          height: 25.0 * ScreenSize.heightMultiplyingFactor,
                          width: 70.0 * ScreenSize.widthMultiplyingFactor,
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
                              "Folklore",
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
