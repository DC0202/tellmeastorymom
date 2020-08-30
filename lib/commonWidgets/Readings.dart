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
import 'package:tellmeastorymom/constants/screenSize.dart';
import 'package:tellmeastorymom/providers/userData.dart';

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
              height: 50.0 * ScreenSize.heightMultiplyingFactor,
              thickness: 1.0,
              color: Color(0xFF707070),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15 * ScreenSize.widthMultiplyingFactor,
                right: 15 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Text(
                "${widget.story.content}",
                style: TextStyle(
                  fontFamily: 'Poppins-Light',
                  fontSize: 15 * ScreenSize.heightMultiplyingFactor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 30.0 * ScreenSize.heightMultiplyingFactor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120.0 * ScreenSize.widthMultiplyingFactor,
                  padding: EdgeInsets.fromLTRB(
                    10 * ScreenSize.widthMultiplyingFactor,
                    10 * ScreenSize.heightMultiplyingFactor,
                    10 * ScreenSize.widthMultiplyingFactor,
                    10 * ScreenSize.heightMultiplyingFactor,
                  ),
                  margin: EdgeInsets.only(
                      left: 15.0 * ScreenSize.widthMultiplyingFactor),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 6.0,
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                  ),
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
                      StreamBuilder<DocumentSnapshot>(
                          stream: firebaseFirestore
                              .collection("PopularStories")
                              .doc(widget.story.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<String> isLiked = [];
                            if (snapshot.hasData) {
                              isLiked = snapshot.data.data()["isLiked"] == null
                                  ? []
                                  : snapshot.data
                                      .data()["isLiked"]
                                      .cast<String>();
                            }
                            print(isLiked.length);
                            return GestureDetector(
                              onTap: () {
                                bool valueOfList =
                                    isLiked.contains(UserData.getUserId());
                                if (valueOfList) {
                                  firebaseFirestore
                                      .collection("PopularStories")
                                      .doc(widget.story.id)
                                      .update({
                                    "isLiked": FieldValue.arrayRemove(
                                        [UserData.getUserId()])
                                  });
                                } else {
                                  firebaseFirestore
                                      .collection("PopularStories")
                                      .doc(widget.story.id)
                                      .update({
                                    "isLiked": FieldValue.arrayUnion(
                                        [UserData.getUserId()])
                                  });
                                }
                              },
                              child: Icon(
                                isLiked.contains(UserData.getUserId())
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 24 * ScreenSize.heightMultiplyingFactor,
                                color: isLiked.contains(UserData.getUserId())
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 50.0 * ScreenSize.heightMultiplyingFactor,
              thickness: 1.0,
              color: Color(0xFF707070),
            ),
            RowViewAll(
              heading: "Recently Viewed",
              onpressed: () {},
            ),
            HomeScreenCardView(
              boxHeight: 210.0 * ScreenSize.heightMultiplyingFactor,
              insideWidth: 220.0 * ScreenSize.widthMultiplyingFactor,
              insideHeight: 141.0 * ScreenSize.heightMultiplyingFactor,
              storyList: popularStories,
              //TODO:CHANGE THE STORY LIST
            ),
            Divider(
              height: 50.0 * ScreenSize.heightMultiplyingFactor,
              thickness: 1.0,
              color: Color(0xFF707070),
            ),
            UserReview(),
            Divider(
              height: 50.0 * ScreenSize.heightMultiplyingFactor,
              thickness: 1.0,
              color: Color(0xFF707070),
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
              height: 50.0 * ScreenSize.heightMultiplyingFactor,
              thickness: 1.0,
              color: Color(0xFF707070),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
              ),
              child: Text(
                'Reader\'s Reviews',
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                ),
              ),
            ),
            CommentList(),
            SizedBox(
              height: 34.0 * ScreenSize.heightMultiplyingFactor,
            ),
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
  String userID = "";

  @override
  void initState() {
    super.initState();
    userID = UserData.getUserId();
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  3.0 * ScreenSize.widthMultiplyingFactor,
                              vertical:
                                  3.0 * ScreenSize.heightMultiplyingFactor),
                          child: Icon(
                            // focusColor: Colors.white.withOpacity(0.8),
                            Icons.arrow_back,
                            size: 24 * ScreenSize.heightMultiplyingFactor,
                          ),
                        ),
                      ),
                      Spacer(),
//                      SizedBox(
//                        width: 220.0 * ScreenSize.widthMultiplyingFactor,
//                      ),
                      GestureDetector(
                        onTap: () {
                          speak();
                        },
                        onDoubleTap: () async {
                          await flutterTts.stop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  3.0 * ScreenSize.widthMultiplyingFactor,
                              vertical:
                                  3.0 * ScreenSize.heightMultiplyingFactor),
                          child: Icon(
                            Icons.volume_up,
                            size: 24 * ScreenSize.heightMultiplyingFactor,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0 * ScreenSize.widthMultiplyingFactor,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: firebaseFirestore
                              .collection("PopularStories")
                              .doc(widget.story.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<String> isBookmarked = [];
                            if (snapshot.hasData) {
                              isBookmarked =
                                  snapshot.data.data()["isBookmarked"] == null
                                      ? []
                                      : snapshot.data
                                          .data()["isBookmarked"]
                                          .cast<String>();
                            }

                            return GestureDetector(
                              onTap: () {
                                bool valueOfList =
                                    isBookmarked.contains(userID);
                                if (valueOfList) {
                                  firebaseFirestore
                                      .collection("PopularStories")
                                      .doc(widget.story.id)
                                      .update({
                                    "isBookmarked":
                                        FieldValue.arrayRemove([userID])
                                  });
                                } else {
                                  firebaseFirestore
                                      .collection("PopularStories")
                                      .doc(widget.story.id)
                                      .update({
                                    "isBookmarked":
                                        FieldValue.arrayUnion([userID])
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        3.0 * ScreenSize.widthMultiplyingFactor,
                                    vertical: 3.0 *
                                        ScreenSize.heightMultiplyingFactor),
                                child: Icon(
                                  isBookmarked.contains(userID)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: isBookmarked.contains(userID)
                                      ? primaryColour
                                      : Colors.black,
                                  size: 24 * ScreenSize.heightMultiplyingFactor,
                                ),
                              ),
                            );
                          }),
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
                  GestureDetector(
                    onTap: () {
                      Share.share('Checkout this amazing story!');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.0 * ScreenSize.widthMultiplyingFactor,
                          vertical: 5.0 * ScreenSize.heightMultiplyingFactor),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
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
          SizedBox(
            height: 33.0 * ScreenSize.heightMultiplyingFactor,
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
            // height: 143.0 * ScreenSize.heightMultiplyingFactor,
            // decoration: BoxDecoration(
            //   shape: BoxShape.rectangle,
            //   border: Border.all(
            //     color: Colors.blue,
            //     width: 1.0,
            //   ),
            // ),
            child: TextField(
              decoration: InputDecoration(
                focusColor: Colors.black.withOpacity(0.3),
                hintText: 'Enter your comment here..',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
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

class CommentList extends StatelessWidget {
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

Widget userRatings(
    {double rating = 4.5,
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
          height: 50.0 * ScreenSize.heightMultiplyingFactor,
          thickness: 0.5,
          color: Color(0xFF707070),
        ),
        RatingBarIndicator(
          rating: 3.60,
          //TODO:add dynamic rating feature here
          itemBuilder: (context, index) => Icon(
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
