import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'package:tellmeastorymom/screenSize.dart';

//final String story =
//    """A long time ago, there lived two kings in two different states. Both the kings were very strong and their kingdom was big, but they were not in talking terms, they did not like each other.
//
//Because both the kings considered themselves superior to the other.
//
//One day both of them went for travel and met each other on a narrow path. Only one chariot was able to cross that narrow path at a time.
//
//Both the kings were adamant and they were not ready to compromise.
//
//Finally, Charioteers started discussing,
//one said “Our king has 1 lakh soldiers, 100-acre fertile land and thousands of animals”,
//“our king also has 1 lakh soldiers, 100-acre fertile land and thousands of animals”, the second charioteer replied.
//
//Both the charioteers were projecting their king more superior than the other.
//
//At last, the first charioteer said: “our king punishes the bad people, hate the lazy person and uses the money for the betterment of the kingdom”.
//
//Our king “helps the bad people to become better person, make lazy people work harder and uses the money for the betterment of poor and needy person” the second charioteer replied.
//
//Now before the first charioteer says anything, the first king came down from his chariot and said ” You are a better human being and made way for the second king”.""";
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class Readings extends StatefulWidget {
  final StoryData story;

  Readings(this.story);

  @override
  _ReadingsState createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
  ];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            StoryHeader(widget.story),
            Divider(
              height: 60.0 * ScreenSize.heightMultiplyingFactor,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15 * ScreenSize.widthMultiplyingFactor,
                right: 15 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Text(
                widget.story.content,
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
                        GestureDetector(
                          onTap: () {
                            likedStories.clear();
                            setState(() {
                              widget.story.isLiked = !widget.story.isLiked;
                            });
                            firebaseFirestore
                                .collection("PopularStories")
                                .doc(widget.story.id)
                                .update({"isLiked": widget.story.isLiked});
                          },
                          child: Icon(
                            widget.story.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 24 * ScreenSize.heightMultiplyingFactor,
                            color: widget.story.isLiked
                                ? Colors.red
                                : Colors.black,
                          ),
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
              storyList: popularStories,
              //TODO:CHANGE THE STORY LIST
            ),
            Divider(
              height: 60.0 * ScreenSize.heightMultiplyingFactor,
              color: Colors.grey,
            ),
            UserReview(),
            Divider(
              height: 60.0 * ScreenSize.heightMultiplyingFactor,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
                vertical: 15.0 * ScreenSize.heightMultiplyingFactor,
              ),
              child: Text(
                'Overall Ratings',
                style: TextStyle(
                  fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0 * ScreenSize.widthMultiplyingFactor,
                right: 15.0 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: 2.75,
                    //TODO:add dynamic rating feature here
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0 * ScreenSize.heightMultiplyingFactor,
                  ),
                  Text(
                    'rating ' + '(number of ratings)',
                    //TODO:dynamic rating
                    style: TextStyle(
                      fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 60.0 * ScreenSize.heightMultiplyingFactor,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                ),
              ),
            ),
            commentList(),
          ],
        ),
      ),
    );
  }
}

class StoryHeader extends StatefulWidget {
  final StoryData story;
  StoryHeader(this.story);
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
      await flutterTts
          .speak(widget.story.title + "          " + widget.story.content);
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
                          onTap: () {
                            speak();
                          },
                          onDoubleTap: () async {
                            await flutterTts.stop();
                          },
                          child: Icon(
                            Icons.volume_up,
                            size: 24 * ScreenSize.heightMultiplyingFactor,
                            color: primaryColour,
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
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.story.isBookmarked =
                              !widget.story.isBookmarked;
                            });
                            firebaseFirestore
                                .collection("PopularStories")
                                .doc(widget.story.id)
                                .update({
                              "isBookmarked": widget.story.isBookmarked
                            });
                          },
                          child: Icon(
                            widget.story.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: primaryColour,
                            size: 24 * ScreenSize.heightMultiplyingFactor,
                            // focusColor: Colors.white.withOpacity(0.8),
                            // icon: Icon(Icons.bookmark_border),
                            // size: 24 * ScreenSize.heightMultiplyingFactor,
                          ),
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
                left: 15 * ScreenSize.heightMultiplyingFactor,
                right: 15 * ScreenSize.heightMultiplyingFactor,
              ),
              child: Row(
                children: [
                  Text(
                    widget.story.title,
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Share.share('Checkout this amazing story!');
                      },
                      child: Icon(
                        Icons.share,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Text(
                widget.story.author,
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
                widget.story.posted,
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
                'Estimated time to complete: ' + widget.story.estimated,
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0 * ScreenSize.widthMultiplyingFactor,
                right: 15.0 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: 2.75,
                    //TODO:add dynamic rating feature here
                    itemBuilder: (context, index) =>
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    itemCount: 5,
                    itemSize: 25.0 * ScreenSize.heightMultiplyingFactor,
                  ),
                  Text(
                    'rating ' + '(number of ratings)',
                    //TODO:dynamic rating
                    style: TextStyle(
                      fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ],
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
                  widget.story.related.length,
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
                            widget.story.related[i],
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

class UserReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Rate story : ',
                style: TextStyle(
                  fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
              Spacer(),
              Container(
                height: 35.0 * ScreenSize.heightMultiplyingFactor,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: RatingBar(
                  onRatingUpdate: (rating) {
                    print('hi');
                  },
                  itemCount: 5,
                  itemSize: 15.0 * ScreenSize.heightMultiplyingFactor,
                  itemBuilder: (context, index) {},
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Please share views to inspire others :',
              style: TextStyle(
                fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
                fontFamily: 'Poppins-Medium',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15.0 * ScreenSize.widthMultiplyingFactor,
            ),
            height: 143.0 * ScreenSize.heightMultiplyingFactor,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your comment here..',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              color: Colors.white,
              elevation: 5.0 * ScreenSize.heightMultiplyingFactor,
              onPressed: () {
                print('Post Comment Pressed');
              },
              child: Text(
                'Post Comment',
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12.0 * ScreenSize.heightMultiplyingFactor,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class commentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return userRatings();
      },
      itemCount: 5,
    );
  }
}

Widget userRatings({double rating = 4.5,
  String userName = 'UserName',
  String commentDate = '00-00-00',
  String commentTitle = 'Title',
  String comment =
  'Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text Long comment text '}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 60.0 * ScreenSize.heightMultiplyingFactor,
          color: Colors.grey,
        ),
        RatingBarIndicator(
          rating: 3.60,
          //TODO:add dynamic rating feature here
          itemBuilder: (context, index) =>
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
          itemCount: 5,
          itemSize: 25.0 * ScreenSize.heightMultiplyingFactor,
        ),
        Text(
          'By ' + userName + ' on ' + commentDate,
          style: TextStyle(
            fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        Text(
          commentTitle,
          style: TextStyle(
            fontFamily: 'Poppins-SemiBold',
            fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
          ),
        ),
        Text(
          comment,
          style: TextStyle(
            fontSize: 14.0 * ScreenSize.heightMultiplyingFactor,
            fontFamily: 'Poppins-Light',
          ),
        ),
      ],
    ),
  );
}
