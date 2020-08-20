import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constants/constant.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/04/19/beach-1867285_1280.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: new StaggeredGridView.countBuilder(
          physics: physicsForApp,
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return new StaggeredTile.count(1, index.isOdd ? 1.1 : 1.1);
          }),
    );
  }
}
