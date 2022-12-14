import 'package:book/models/news_model.dart';
import 'package:book/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.listData}) : super(key: key);

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
        leading: const BackButton(color: Colors.black),
        actions: [
          InkWell(
            splashColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(color: const Color.fromARGB(120, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
              width: 45,
              margin: const EdgeInsets.all(7),
              child: const Center(
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
                decoration: BoxDecoration(color: const Color.fromARGB(120, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                width: 45,
                margin: const EdgeInsets.all(7),
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
              decoration: BoxDecoration(color: const Color.fromARGB(120, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
              width: 45,
              margin: const EdgeInsets.all(7),
              child: const Center(
                  child: Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
            ),
            onTap: () {},
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(138, 204, 204, 204),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage(widget.listData.urlToImage.toString()), fit: BoxFit.cover)),
              width: 400,
              height: 250,
              margin: const EdgeInsets.only(top: 20),
            ),
            const SizedBox(height: 20),
            Text(
              widget.listData.title.toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
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
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(138, 204, 204, 204),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(widget.listData.urlToImage.toString()), fit: BoxFit.cover)),
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.listData.source!.name.toString()),
                    const SizedBox(height: 10),
                    Text('${widget.listData.publishedAt!.year}-${widget.listData.publishedAt!.month}-${widget.listData.publishedAt!.day}'),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      setState(() {
                        isChecked = !isChecked;
                        isFollow = !isFollow;
                      });
                    },
                    child: Row(
                      children: [Icon(isChecked ? Icons.check : Icons.add), const SizedBox(width: 5), Text(isFollow ? 'Following' : 'Follow')],
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.listData.content.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              widget.listData.description.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
