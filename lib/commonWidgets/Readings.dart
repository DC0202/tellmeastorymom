import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:tellmeastorymom/commonWidgets/HomeScreenCardView.dart';
import 'package:tellmeastorymom/commonWidgets/rowForViewAll.dart';
import 'package:tellmeastorymom/constants/constant.dart';
import 'package:tellmeastorymom/constants/screenSize.dart';
import 'package:tellmeastorymom/providers/commentData.dart';
import 'package:tellmeastorymom/providers/storyData.dart';
import 'package:tellmeastorymom/providers/userData.dart';

import 'StoriesScreen.dart';
import 'commentList.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class Readings extends StatefulWidget {
  final StoryData story;

  const Readings({Key key, this.story}) : super(key: key);

  @override
  _ReadingsState createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<CommentData> commentList = [];
  List<String> recents = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            StoryHeader(
              story: widget.story,
            ),
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
                widget.story.content.replaceAll(RegExp(r'\\n'), "\n"),
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
                            .collection("Stories")
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
                                    .collection("Stories")
                                    .doc(widget.story.id)
                                    .update({
                                  "isLiked": FieldValue.arrayRemove(
                                      [UserData.getUserId()])
                                });
                              } else {
                                firebaseFirestore
                                    .collection("Stories")
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
                        },
                      ),
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
              heading: "Recently Viewed Stories",
              onpressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StoriesScreen(
                      heading: "Recently Viewed Stories",
                      itemCount: recentlyViewedStories.length,
                      storyList: recentlyViewedStories,
                    ),
                  ),
                );
                // print("Pressed Recently Viewed Stories View All");
              },
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: firebaseFirestore
                  .collection("Users")
                  .doc(UserData.getUserId())
                  .snapshots(),
              builder: (context, snapshot) {
                recents.clear();
                if (snapshot.hasData) {
                  recents = snapshot.data.data()["recents"] == null
                      ? []
                      : snapshot.data.data()["recents"].cast<String>();
                  return StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore.collection("Stories").snapshots(),
                    builder: (context, snapshot) {
                      recentlyViewedStories.clear();
                      if (snapshot.hasData) {
                        for (var i = 0; i < recents.length; i++) {
                          snapshot.data.docs.forEach((result) {
                            if (recents[i] == result.id) {
                              recentlyViewedStories
                                  .add(StoryData.fromSnapshot(result));
                            }
                          });
                        }

                        return HomeScreenCardView(
                          boxHeight: 210 * ScreenSize.heightMultiplyingFactor,
                          insideHeight:
                              141 * ScreenSize.heightMultiplyingFactor,
                          insideWidth: 220 * ScreenSize.widthMultiplyingFactor,
                          storyList: recentlyViewedStories,
                          itemCard: true,
                        );
                      }
                      return circularProgressIndicator();
                    },
                  );
                }
                return circularProgressIndicator();
              },
            ),
            Divider(
              height: 50.0 * ScreenSize.heightMultiplyingFactor,
              thickness: 1.0,
              color: Color(0xFF707070),
            ),
            UserReview(
              storyId: widget.story.id,
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
            StreamBuilder<QuerySnapshot>(
              stream: firebaseFirestore
                  .collection('Stories')
                  .doc(widget.story.id)
                  .collection('Comments')
                  .snapshots(),
              builder: (context, snapshot) {
                commentList.clear();
                if (snapshot.hasData) {
                  snapshot.data.docs.forEach((result) {
                    commentList.add(CommentData.fromSnapshot(result));
                    print(result);
                  });
                }
                // print(commentList[0]);
                return CommentList(
                  hasRating: true,
                  commentList: commentList,
                );
                // }
                // return circularProgressIndicator();
              },
            ),
            SizedBox(
              height: 15.0 * ScreenSize.heightMultiplyingFactor,
            ),
          ],
        ),
      ),
    );
  }
}

class StoryHeader extends StatefulWidget {
  final StoryData story;

  const StoryHeader({Key key, this.story}) : super(key: key);
  @override
  _StoryHeaderState createState() => _StoryHeaderState();
}

class _StoryHeaderState extends State<StoryHeader> {
  final FlutterTts flutterTts = FlutterTts();

  List<Color> colorList = [
    Color(0xFF5A8FD8),
    Color(0xFFFF5954),
    Color(0xFFFF9870),
    Color(0xFF6D60F8)
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
      await flutterTts.setPitch(1.4);
      await flutterTts.setSpeechRate(0.85);
      await flutterTts.speak(
          widget.story.title.replaceAll(RegExp(r'\\n'), "\n") +
              "\n\n\n\n" +
              widget.story.content.replaceAll(RegExp(r'\\n'), "\n"));
    }

    double overallRating = 0;
    int commentCount = 0;
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
                      // image: AssetImage(
                      //   'assets/images/cardImage.jpg',
                      // ),
                      image: AdvancedNetworkImage(
                        widget.story.storyImageURL,
                        useDiskCache: true,
                        cacheRule: CacheRule(maxAge: const Duration(days: 2)),
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
                        onTap: () async {
                          await flutterTts.stop();
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
                            size: 35 * ScreenSize.heightMultiplyingFactor,
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
                            size: 35 * ScreenSize.heightMultiplyingFactor,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0 * ScreenSize.widthMultiplyingFactor,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: firebaseFirestore
                            .collection("Stories")
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
                              bool valueOfList = isBookmarked.contains(userID);
                              if (valueOfList) {
                                firebaseFirestore
                                    .collection("Stories")
                                    .doc(widget.story.id)
                                    .update({
                                  "isBookmarked":
                                      FieldValue.arrayRemove([userID])
                                });
                              } else {
                                firebaseFirestore
                                    .collection("Stories")
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
                                  vertical:
                                      3.0 * ScreenSize.heightMultiplyingFactor),
                              child: Icon(
                                isBookmarked.contains(userID)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: isBookmarked.contains(userID)
                                    ? primaryColour
                                    : Colors.black,
                                size: 35 * ScreenSize.heightMultiplyingFactor,
                              ),
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
              height: 15.0 * ScreenSize.heightMultiplyingFactor,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 15 * ScreenSize.heightMultiplyingFactor,
                right: 15 * ScreenSize.heightMultiplyingFactor,
              ),
              child: Row(
                children: [
                  Container(
                    width: 300 * ScreenSize.widthMultiplyingFactor,
                    child: Text(
                      widget.story.title,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 18.0 * ScreenSize.heightMultiplyingFactor,
                        color: Colors.black,
                      ),
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
                        size: 35 * ScreenSize.heightMultiplyingFactor,
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
              padding: EdgeInsets.symmetric(
                horizontal: 15.0 * ScreenSize.widthMultiplyingFactor,
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore
                    .collection('Stories')
                    .doc(widget.story.id)
                    .collection('Comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  overallRating = 0;
                  commentCount = 0;
                  if (snapshot.hasData) {
                    snapshot.data.docs.forEach((result) {
                      commentCount++;
                      overallRating +=
                          double.parse(result.data()['ratingStars'].toString());
                      print(result);
                    });
                    overallRating /= commentCount;
                  }
                  // print(commentList[0]);
                  return commentCount == 0
                      ? SizedBox()
                      : Row(
                          children: [
                            RatingBarIndicator(
                              rating: overallRating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize:
                                  25.0 * ScreenSize.heightMultiplyingFactor,
                            ),
                            Text(
                              "   " + overallRating.toStringAsFixed(1),
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize:
                                    14.0 * ScreenSize.heightMultiplyingFactor,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "   (" + commentCount.toString() + " ratings)",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize:
                                    14.0 * ScreenSize.heightMultiplyingFactor,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        );
                  // }
                  // return circularProgressIndicator();
                },
              ),
            ),
            SizedBox(
              height: 8.0 * ScreenSize.heightMultiplyingFactor,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15 * ScreenSize.heightMultiplyingFactor),
              child: Wrap(
                spacing: 5.0 * ScreenSize.widthMultiplyingFactor,
                runSpacing: 5.0,
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
                            color: colorList[i % colorList.length],
                          ),
                          child: Text(
                            widget.story.related[i],
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize:
                                  12.0 * ScreenSize.heightMultiplyingFactor,
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

class UserReview extends StatefulWidget {
  final String storyId;

  const UserReview({Key key, this.storyId}) : super(key: key);

  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  double ratingStar = 3.0;
  String comment = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  bool _autoValidate = false;

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
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0 * ScreenSize.widthMultiplyingFactor,
                ),
                height: 45.0 * ScreenSize.heightMultiplyingFactor,
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
                child: Center(
                  child: RatingBar(
                    initialRating: 3,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0 * ScreenSize.heightMultiplyingFactor,
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        ratingStar = rating;
                      });
                    },
                  ),
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
          Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Container(
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
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    comment = value;
                  });
                },
                validator: (value) {
                  if (value.length < 80)
                    return "Minimum 80 characters required";
                  return null;
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  focusColor: Colors.black.withOpacity(0.3),
                  hintText: 'Enter your comment here..',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                maxLength: 245,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
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
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  CommentData commentData = CommentData(
                      commentBy: UserData.getUserName(),
                      content: comment.trim(),
                      ratingStars: ratingStar,
                      postedOn: DateFormat("dd-MM-yy").format(DateTime.now()));
                  //good story aa to gaya neeche
                  firebaseFirestore
                      .collection('Stories')
                      .doc(widget.storyId)
                      .collection('Comments')
                      .add(commentData.toJson());

                  setState(() {
                    textEditingController.clear();
                    _autoValidate = false;
                  });
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
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
