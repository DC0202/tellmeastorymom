import 'package:flutter/material.dart';

class RowViewAll extends StatelessWidget {
  final String heading;
  final Function onpressed;

  const RowViewAll({Key key, this.heading, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, right: 28.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          GestureDetector(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(15.0),
            // ),
            // onPressed: onpressed,
            // padding: EdgeInsets.all(0),
            onTap: onpressed,
            child: Align(
              alignment: Alignment.centerRight,
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
