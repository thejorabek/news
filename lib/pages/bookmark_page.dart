import 'package:book/main.dart';
import 'package:book/provider/bookmark_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        centerTitle: true,
      ),
      body: Consumer(builder: ((context, value, child) {
        return ListView.builder(
            itemCount: box.read('bookmarks').length,
            // itemCount: context.watch<BookmarkProvider>().bookMark.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CachedNetworkImage(imageUrl: context.watch<BookmarkProvider>().bookMark[index].urlToImage.toString()),
                  title: Text(
                    context.watch<BookmarkProvider>().bookMark[index].title.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            });
      })),
    );
  }
}
