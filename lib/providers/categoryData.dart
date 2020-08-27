import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tellmeastorymom/providers/storyData.dart';

class CategoryData {
  String id;
  String categoryName;
  List<StoryData> categoryStories;

  CategoryData({this.categoryName, this.categoryStories, this.id});

  CategoryData.fromSnapshot(DocumentSnapshot snapshot) {
    // List<StoryData> val = [];

    this.categoryName = snapshot.data()['categoryName'];
    // this.categoryStories = snapshot.data()['categoryStories'].forEach((result) {
    //   val.add(StoryData.fromSnapshot(result));
    // });
    this.id = snapshot.id.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'catcategoryName': categoryName,
      // 'categoryStories': categoryStories,
      'id': id,
    };
  }
}

List<CategoryData> categories = [];
