import 'package:book/models/news_model.dart';
import 'package:book/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key? key, required this.listData}) : super(key: key);

  final Article listData;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isFollow = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [
          InkWell(
            splashColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(color: Color.fromARGB(120, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
              width: 45,
              margin: EdgeInsets.all(7),
              child: Center(
                  child: Icon(
                Icons.share,
                color: Colors.black,
              )),
            ),
            onTap: () {},
          ),
          Consumer(builder: ((context, value, child) {
            return InkWell(
              splashColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(color: Color.fromARGB(120, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                width: 45,
                margin: EdgeInsets.all(7),
                child: Center(
                    child: Icon(
                  context.watch<BookmarkProvider>().isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.black,
                )),
              ),
              onTap: () {
                context.read<BookmarkProvider>().addToBookmark(widget.listData);
                context.read<BookmarkProvider>().toBookmark();
              },
            );
          })),
          InkWell(
            splashColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(color: Color.fromARGB(120, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
              width: 45,
              margin: EdgeInsets.all(7),
              child: Center(
                  child: Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
            ),
            onTap: () {},
          ),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage(widget.listData.urlToImage.toString()), fit: BoxFit.cover)),
              width: 400,
              height: 250,
              margin: EdgeInsets.only(top: 20),
            ),
            SizedBox(height: 20),
            Text(
              widget.listData.title.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.remove_red_eye,
                  size: 18,
                ),
                Text('638.8K'),
                Icon(
                  Icons.thumb_up,
                  size: 18,
                ),
                Text('381.4K'),
                Icon(
                  Icons.comment,
                  size: 18,
                ),
                Text('170.5K')
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(widget.listData.urlToImage.toString()), fit: BoxFit.cover)),
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.listData.source!.name.toString()),
                    SizedBox(height: 10),
                    Text(widget.listData.publishedAt!.year.toString() +
                        '-' +
                        widget.listData.publishedAt!.month.toString() +
                        '-' +
                        widget.listData.publishedAt!.day.toString()),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      setState(() {
                        isChecked = !isChecked;
                        isFollow = !isFollow;
                      });
                    },
                    child: Row(
                      children: [Icon(isChecked ? Icons.check : Icons.add), SizedBox(width: 5), Text(isFollow ? 'Following' : 'Follow')],
                    ))
              ],
            ),
            SizedBox(height: 20),
            Text(
              widget.listData.content.toString(),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              widget.listData.description.toString(),
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
