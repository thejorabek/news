import 'package:book/models/news_model.dart';
import 'package:book/provider/bookmark_provider.dart';
import 'package:book/services/book_service.dart';
import 'package:book/widgets/latest_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../pages/info_page.dart';

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
          return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(top: height * .03, left: width * .03, right: width * .03),
                    child: Container(
                        decoration: BoxDecoration(color: Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                        width: width * .34,
                        height: height * .17,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(70, 158, 158, 158),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                            width: width * .15,
                            height: height * .17,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 100,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 70,
                                  height: 15,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Color.fromARGB(70, 158, 158, 158),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                      width: 70,
                                      height: 15,
                                    )
                                  ],
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        ])));
              });
        } else if (snapshot.hasError) {
          return Center(
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
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return Consumer<BookmarkProvider>(builder: (context, value, child) {
                        return InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(top: height * .03, left: width * .05, right: width * .05),
                            child: Container(
                              decoration: BoxDecoration(color: Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                              width: width * .34,
                              height: height * .2,
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
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
                                                    style: TextStyle(
                                                      wordSpacing: 2,
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                              ),
                                              SizedBox(height: height * .04),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
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
                                                Text(
                                                  '155K',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.comment),
                                                  iconSize: 18,
                                                ),
                                                Text('155K', style: TextStyle(fontSize: 12)),
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

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  bool isFav = false;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookService.bookService(),
      builder: (context, AsyncSnapshot<NewsModel> snapshot) {
        if (!snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  width: 340,
                  height: 170,
                  decoration: BoxDecoration(color: Color.fromARGB(55, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(color: Color.fromARGB(122, 158, 158, 158), width: 100, height: 15),
                      SizedBox(height: 25),
                      Container(color: Color.fromARGB(122, 158, 158, 158), width: 200, height: 15),
                      SizedBox(height: 5),
                      Container(color: Color.fromARGB(122, 158, 158, 158), width: 270, height: 15),
                      SizedBox(height: 5),
                      Container(color: Color.fromARGB(122, 158, 158, 158), width: 100, height: 15),
                      SizedBox(height: 5),
                    ]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Container(
                        decoration: BoxDecoration(color: Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                        width: 340,
                        height: 170,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(70, 158, 158, 158),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                            width: 150,
                            height: 170,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 100,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 70,
                                  height: 15,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Color.fromARGB(70, 158, 158, 158),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                      width: 70,
                                      height: 15,
                                    )
                                  ],
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(70, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ]))),
                Padding(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Container(
                        decoration: BoxDecoration(color: Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                        width: 340,
                        height: 170,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(125, 158, 158, 158),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                            width: 150,
                            height: 170,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(118, 158, 158, 158)),
                                  width: 100,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(113, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(127, 158, 158, 158)),
                                  width: 70,
                                  height: 15,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Color.fromARGB(122, 158, 158, 158),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(color: Color.fromARGB(117, 158, 158, 158)),
                                      width: 70,
                                      height: 15,
                                    )
                                  ],
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(111, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ]))),
                Padding(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Container(
                        decoration: BoxDecoration(color: Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                        width: 340,
                        height: 170,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(125, 158, 158, 158),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                            width: 150,
                            height: 170,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(118, 158, 158, 158)),
                                  width: 100,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(113, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(127, 158, 158, 158)),
                                  width: 70,
                                  height: 15,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Color.fromARGB(122, 158, 158, 158),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(color: Color.fromARGB(117, 158, 158, 158)),
                                      width: 70,
                                      height: 15,
                                    )
                                  ],
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(111, 158, 158, 158)),
                                  width: 140,
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ])))
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error'),
          );
        } else {
          return ListView(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Color.fromARGB(52, 158, 158, 158)),
                    width: 410,
                    height: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: PageView(physics: BouncingScrollPhysics(), controller: controller, scrollDirection: Axis.horizontal, children: [
                          GestureDetector(
                            child: LatestNews(
                                author: snapshot.data!.articles![0].author.toString(),
                                backImage: snapshot.data!.articles![0].urlToImage.toString(),
                                day: snapshot.data!.articles![0].publishedAt!.day.toString(),
                                month: snapshot.data!.articles![0].publishedAt!.month.toString(),
                                title: snapshot.data!.articles![0].title.toString(),
                                year: snapshot.data!.articles![0].publishedAt!.year.toString()),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(listData: snapshot.data!.articles![0])));
                            },
                          ),
                          GestureDetector(
                            child: LatestNews(
                                author: snapshot.data!.articles![10].author.toString(),
                                backImage: snapshot.data!.articles![10].urlToImage.toString(),
                                day: snapshot.data!.articles![10].publishedAt!.day.toString(),
                                month: snapshot.data!.articles![10].publishedAt!.month.toString(),
                                title: snapshot.data!.articles![10].title.toString(),
                                year: snapshot.data!.articles![10].publishedAt!.year.toString()),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(listData: snapshot.data!.articles![10])));
                            },
                          ),
                          GestureDetector(
                            child: LatestNews(
                                author: snapshot.data!.articles![20].author.toString(),
                                backImage: snapshot.data!.articles![20].urlToImage.toString(),
                                day: snapshot.data!.articles![20].publishedAt!.day.toString(),
                                month: snapshot.data!.articles![20].publishedAt!.month.toString(),
                                title: snapshot.data!.articles![20].title.toString(),
                                year: snapshot.data!.articles![20].publishedAt!.year.toString()),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(listData: snapshot.data!.articles![20])));
                            },
                          ),
                        ]),
                      ),
                      SizedBox(height: 5),
                      SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: ExpandingDotsEffect(activeDotColor: Colors.black, dotHeight: 7, dotWidth: 7),
                      )
                    ],
                  ),
                  SizedBox(height: 9),
                  Container(
                    decoration: BoxDecoration(color: Color.fromARGB(52, 158, 158, 158)),
                    width: 410,
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 451,
                child: LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  springAnimationDurationInMilliseconds: 1000,
                  onRefresh: BookService.bookService,
                  child: ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Container(
                            decoration: BoxDecoration(color: Color.fromARGB(45, 158, 158, 158), borderRadius: BorderRadius.circular(10)),
                            width: 340,
                            height: 170,
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.articles![index].urlToImage.toString()), fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                width: 150,
                                height: 170,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 162,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 158,
                                              child: Text(snapshot.data!.articles![index].title.toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    wordSpacing: 2,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(snapshot.data!.articles![index].urlToImage.toString()),
                                                          fit: BoxFit.cover)),
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  snapshot.data!.articles![index].source!.name.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 7),
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
                                              Text(
                                                '155K',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.comment),
                                                iconSize: 18,
                                              ),
                                              Text('155K', style: TextStyle(fontSize: 12)),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoPage(
                                        listData: snapshot.data!.articles![index],
                                      )));
                        },
                      );
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
