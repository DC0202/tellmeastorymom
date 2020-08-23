import 'package:cloud_firestore/cloud_firestore.dart';

class StoryData {
  String id;
  String storyImageURL;
  String title;
  bool isBookmarked;
  String author;
  List<String> related;
  String posted;
  String estimated;
  String content;
  bool isLiked;

  StoryData(
      {this.author,
      this.content,
      this.estimated,
      this.id,
      this.isBookmarked,
      this.isLiked,
      this.posted,
      this.related,
      this.storyImageURL,
      this.title});

  StoryData.fromSnapshot(DocumentSnapshot snapshot) {
    this.author = snapshot.data()['author'];
    this.content = snapshot.data()['content'];
    this.estimated = snapshot.data()['estimated'];
    this.id = snapshot.id.toString();
    this.isBookmarked = snapshot.data()['isBookmarked'];
    this.isLiked = snapshot.data()['isLiked'];
    this.posted = snapshot.data()['posted'];
    this.related = snapshot.data()['related'].cast<String>();
    this.storyImageURL = snapshot.data()['storyImageURL'];
    this.title = snapshot.data()['title'];
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "firstName": _firstName,
  //     "lastName": _lastName,
  //     "designation": _designation,
  //     "phone": _phone,
  //     "email": _email,
  //     "address": _address,
  //     "dob": _dob,
  //   };
  // }
}

List<StoryData> popularStories = [];
List<StoryData> recommendedStories = [];
List<StoryData> latestStories = [];
