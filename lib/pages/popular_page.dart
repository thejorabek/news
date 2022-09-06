import 'package:book/models/news_model.dart';
import 'package:book/provider/bookmark_provider.dart';
import 'package:book/services/book_service.dart';
import 'package:book/utils/shimmers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'info_page.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  bool isFav = true;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: BookService.bookService(),
      builder: (context, AsyncSnapshot<NewsModel> snapshot) {
        if (!snapshot.hasData) {
          return FirstShimmer(height, width);
        } else if (snapshot.hasError) {
          return const Center(
            child: Center(
              child: Icon(
                Icons.restore_page_sharp,
                size: 45,
                color: Colors.black,
              ),
            ),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: height * .81,
                child: LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  springAnimationDurationInMilliseconds: 500,
                  onRefresh: BookService.bookService,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return Consumer<BookmarkProvider>(builder: (context, value, child) {
                        return InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(top: height * .03, left: width * .05, right: width * .05),
                            child: Container(
                              decoration: BoxDecoration(color: const Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                              width: width * .34,
                              height: height * .2,
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                  decoration:
                                      const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                  width: width * .37,
                                  height: height * .2,
                                  child: ClipRRect(
                                      child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * .02),
                                  child: SizedBox(
                                    width: width * .5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: width * .03),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .5,
                                                child: Text(snapshot.data!.articles![index].title.toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      wordSpacing: 2,
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                              ),
                                              SizedBox(height: height * .04),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    width: width * .06,
                                                    height: height * .03,
                                                    child: ClipOval(
                                                        child: CachedNetworkImage(
                                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                                      fit: BoxFit.cover,
                                                    )),
                                                  ),
                                                  SizedBox(width: width * .02),
                                                  SizedBox(
                                                    width: width * .35,
                                                    child: Text(
                                                      snapshot.data!.articles![index].source!.name.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: height * .01),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: width * .02),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isFav = !isFav;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      isFav ? Icons.thumb_up_outlined : Icons.thumb_up,
                                                      size: 18,
                                                    )),
                                                const Text(
                                                  '155K',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.comment),
                                                  iconSize: 18,
                                                ),
                                                const Text('155K', style: TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                          onTap: () {
                            context.read<BookmarkProvider>().toBookmark();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoPage(
                                          listData: snapshot.data!.articles![index],
                                        )));
                          },
                        );
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
