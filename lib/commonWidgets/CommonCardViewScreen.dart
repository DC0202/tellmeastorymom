import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';

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
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 180.0,
                        width: 375.0,
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
                        padding: const EdgeInsets.all(8.0),
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
                              padding: EdgeInsets.all(5.0),
                              child: GestureDetector(
                                // focusColor: Colors.white.withOpacity(0.8),
                                child: Icon(
                                  widget.bookmark
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: widget.bookmark
                                      ? primaryColour
                                      : Colors.black,
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
                    height: 6.0,
                  ),
                  Text(
                    "Little red riding hood",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "By tellmeastorymom",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Wrap(
                    spacing: 5.0,
                    // runSpacing: 7.0,
                    children: List<Widget>.generate(
                      3,
                      (int i) {
                        return Container(
                          height: 25.0,
                          width: 70.0,
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: colorList[i],
                          ),
                          child: Center(
                            child: Text(
                              "Folklore",
                              style: TextStyle(
                                fontSize: 10.0,
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
