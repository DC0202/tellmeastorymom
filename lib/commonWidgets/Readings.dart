import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/screenSize.dart';

final String story =
    """A long time ago, there lived two kings in two different states. Both the kings were very strong and their kingdom was big, but they were not in talking terms, they did not like each other.

Because both the kings considered themselves superior to the other.

One day both of them went for travel and met each other on a narrow path. Only one chariot was able to cross that narrow path at a time.

Both the kings were adamant and they were not ready to compromise.

Finally, Charioteers started discussing,
one said “Our king has 1 lakh soldiers, 100-acre fertile land and thousands of animals”,
“our king also has 1 lakh soldiers, 100-acre fertile land and thousands of animals”, the second charioteer replied.

Both the charioteers were projecting their king more superior than the other.

At last, the first charioteer said: “our king punishes the bad people, hate the lazy person and uses the money for the betterment of the kingdom”.

Our king “helps the bad people to become better person, make lazy people work harder and uses the money for the betterment of poor and needy person” the second charioteer replied.

Now before the first charioteer says anything, the first king came down from his chariot and said ” You are a better human being and made way for the second king”.""";

class Readings extends StatefulWidget {
  @override
  _ReadingsState createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          physics: physicsForApp,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            StoryHeader(),
            Divider(
              height: 60.0 * ScreenSize.heightMultiplyingFactor,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Text(
                story,
                style: TextStyle(
                  fontFamily: 'Poppins-Light',
                  fontSize: 15 * ScreenSize.heightMultiplyingFactor,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(
            //                16 * ScreenSize.widthMultiplyingFactor,
            //                30 * ScreenSize.heightMultiplyingFactor,
            //                280 * ScreenSize.widthMultiplyingFactor,
            //                20 * ScreenSize.heightMultiplyingFactor,),
            //   child: RaisedButton(
            //     padding: EdgeInsets.all(0.0),
            //     onPressed: () {},
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Like Story:',
            //         ),
            //         SizedBox(
            //           width: 18.0,
            //         ),
            //         Icon(
            //           Icons.favorite_border,
            //           color: Colors.black,
            //         )
            //       ],
            //     ),
            //     color: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 30.0 * ScreenSize.heightMultiplyingFactor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160.0 * ScreenSize.widthMultiplyingFactor,
                  padding: EdgeInsets.fromLTRB(
                    15 * ScreenSize.widthMultiplyingFactor,
                    15 * ScreenSize.heightMultiplyingFactor,
                    15 * ScreenSize.widthMultiplyingFactor,
                    15 * ScreenSize.heightMultiplyingFactor,
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(
                      10 * ScreenSize.widthMultiplyingFactor,
                      10 * ScreenSize.heightMultiplyingFactor,
                      10 * ScreenSize.widthMultiplyingFactor,
                      10 * ScreenSize.heightMultiplyingFactor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {},
                    color: Colors.white,
                    elevation: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Like story: ",
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 12 * ScreenSize.heightMultiplyingFactor,
                          ),
                        ),
                        SizedBox(
                          width: 15.0 * ScreenSize.widthMultiplyingFactor,
                        ),
                        Icon(
                          Icons.favorite_border,
                          size: 24 * ScreenSize.heightMultiplyingFactor,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 60.0 * ScreenSize.heightMultiplyingFactor,
              color: Colors.grey,
            ),
            RowViewAll(
              heading: "Similar Stories",
              onpressed: () {
//              Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context) => StoriesScreen(
//                        heading: "Submitted Stories",
//                        itemCount: 20,
//                      )));
//              print("Pressed Submitted Stories View All");
              },
            ),
            HomeScreenCardView(
              boxHeight: 210.0 * ScreenSize.heightMultiplyingFactor,
              insideWidth: 220.0 * ScreenSize.widthMultiplyingFactor,
              insideHeight: 141.0 * ScreenSize.heightMultiplyingFactor,
              itemCountOfCard: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class StoryHeader extends StatefulWidget {
  @override
  _StoryHeaderState createState() => _StoryHeaderState();
}

class _StoryHeaderState extends State<StoryHeader> {
  final FlutterTts flutterTts = FlutterTts();

  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];

  @override
  void initState() {
    super.initState();
    // flutterTts.setCancelHandler(() {
    //   flutterTts.stop();
    // });
  }

  @override
  Widget build(BuildContext context) {
    speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.3);
      await flutterTts.setSpeechRate(0.9);
      await flutterTts.speak("Little red riding hood.         " + story);
    }

    return WillPopScope(
      onWillPop: () async {
        await flutterTts.stop();
        Navigator.of(context).pop();
      },
      child: Container(
//      margin: EdgeInsets.only(right: 0.0, left: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 250.0 * ScreenSize.heightMultiplyingFactor,
                  width: 450.0 * ScreenSize.widthMultiplyingFactor,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          // focusColor: Colors.white.withOpacity(0.8),
                          icon: Icon(Icons.arrow_back),
                          iconSize: 24 * ScreenSize.heightMultiplyingFactor,
                          onPressed: () {
                            // print(
                            //   "Widget Index" + index.toString(),
                            // );
                          },
                        ),
                      ),
                      Spacer(),
//                      SizedBox(
//                        width: 220.0 * ScreenSize.widthMultiplyingFactor,
//                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          child: IconButton(
                            // focusColor: Colors.white.withOpacity(0.8),
                            icon: Icon(Icons.volume_up),
                            iconSize: 24 * ScreenSize.heightMultiplyingFactor,
                            onPressed: () {
                              speak();
                              // print(
                              //   "Widget Index" + index.toString(),
                              // );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0 * ScreenSize.widthMultiplyingFactor,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          // focusColor: Colors.white.withOpacity(0.8),
                          icon: Icon(Icons.bookmark_border),
                          iconSize: 24 * ScreenSize.heightMultiplyingFactor,
                          onPressed: () {
                            // print(
                            //   "Widget Index" + index.toString(),
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0 * ScreenSize.heightMultiplyingFactor,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Text(
                "Little red riding hood",
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Text(
                "By tellmeastorymom",
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Text(
                "Posted on June 20 , 2020",
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Text(
                "Estimated time to complete: 5 mins",
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(
              height: 8.0 * ScreenSize.heightMultiplyingFactor,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Wrap(
                spacing: 10.0 * ScreenSize.widthMultiplyingFactor,
                // runSpacing: 7.0,
                children: List<Widget>.generate(
                  3,
                  (int i) {
                    return Column(
                      children: <Widget>[
                        Container(
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
