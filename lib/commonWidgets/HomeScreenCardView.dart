import 'package:flutter/material.dart';
import 'package:tellmeastorymom/constants/constant.dart';

import 'Readings.dart';

class HomeScreenCardView extends StatefulWidget {
  final double boxHeight;
  final double insideHeight;
  final double insideWidth;
  final int itemCountOfCard;
  final bool itemCard;

  const HomeScreenCardView(
      {Key key,
      this.boxHeight,
      this.insideHeight,
      this.insideWidth,
      this.itemCard = false,
      this.itemCountOfCard})
      : super(key: key);

  @override
  _HomeScreenCardViewState createState() => _HomeScreenCardViewState();
}

class _HomeScreenCardViewState extends State<HomeScreenCardView> {
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: size.width,
      height: widget.boxHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
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
              margin:
                  EdgeInsets.only(right: 15.0, left: index == 0 ? 15.0 : 0.0),
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
                                child: Icon(Icons.bookmark_border),
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
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "By tellmeastorymom",
                    style: TextStyle(
                      fontSize: 9.0,
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
