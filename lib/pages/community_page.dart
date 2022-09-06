import 'package:book/models/news_model.dart';
import 'package:book/pages/info_page.dart';
import 'package:book/services/book_service.dart';
import 'package:book/utils/shimmers.dart';
import 'package:book/widgets/latest_news.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: BookService.bookService(),
      builder: (context, AsyncSnapshot<NewsModel> snapshot) {
        if (!snapshot.hasData) {
          return SecondShimmer(height, width);
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
