import 'package:flutter/material.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
              height: 60.0,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                story,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 280, 20),
              child: RaisedButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Like Story:',
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.black,
                    )
                  ],
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Divider(
              height: 60.0,
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
              boxHeight: 210.0,
              insideWidth: 220.0,
              insideHeight: 141.0,
              itemCountOfCard: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class StoryHeader extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];
  @override
  Widget build(BuildContext context) {
    speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.3);
      await flutterTts.setSpeechRate(0.9);

      await flutterTts.speak("Little red riding hood.         " + story);
    }

    return Container(
//      margin: EdgeInsets.only(right: 0.0, left: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 250.0,
                width: 450.0,
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
                        onPressed: () {
                          // print(
                          //   "Widget Index" + index.toString(),
                          // );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 220.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        child: IconButton(
                          // focusColor: Colors.white.withOpacity(0.8),
                          icon: Icon(Icons.volume_up),
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
                      width: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        // focusColor: Colors.white.withOpacity(0.8),
                        icon: Icon(Icons.bookmark_border),
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
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Little red riding hood",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "By tellmeastorymom",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Posted on June 20 , 2020",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Estimated time to complete: 5 mins",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Wrap(
              spacing: 10.0,
              // runSpacing: 7.0,
              children: List<Widget>.generate(
                3,
                (int i) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 25.0,
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: colorList[i],
                        ),
                        child: Text(
                          "Folklore",
                          style: TextStyle(
                            fontSize: 15.0,
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
    );
  }
}
