import 'package:flutter/material.dart';

class LatestNews extends StatelessWidget {
  LatestNews({
    Key? key,
    required this.author,
    required this.backImage,
    required this.day,
    required this.month,
    required this.title,
    required this.year,
  }) : super(key: key);

  String backImage;
  String author;
  String title;
  String day;
  String month;
  String year;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, image: DecorationImage(image: NetworkImage(backImage), fit: BoxFit.cover), borderRadius: BorderRadius.circular(5)),
      width: 340,
      height: 150,
      margin: EdgeInsets.only(top: 29, left: 30, right: 30),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'by ' + author,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 229),
                child: Text(
                  day + '-' + month + '-' + year,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}