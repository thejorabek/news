import 'package:book/pages/community_page.dart';
import 'package:book/pages/popular_page.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isSearch = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: isSearch
              ? SizedBox(
                  height: height*.04,
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        hintText: 'Search News', hintStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic), border: InputBorder.none),
                  ),
                )
              : const Text('News'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: Icon(isSearch ? Icons.clear : Icons.search),
              iconSize: 28,
            ),
            SizedBox(width: width*.05)
          ],
          bottom: TabBar(
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(57, 255, 255, 255)),
            tabs: [
              const Tab(
                text: 'Popular',
              ),
              const Tab(text: 'Community')
            ],
            labelStyle: const TextStyle(fontSize: 15),
            indicatorWeight: 3,
          ),
        ),
        drawer: const MyDrawer(),
        body: const TabBarView(children: [FirstTab(), SecondTab()]),
      ),
    );
  }
}
