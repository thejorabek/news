import 'package:book/utils/tabbar.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isSearch = false;

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return 
    DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: isSearch
              ? SizedBox(
                  height: 40,
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(hintText: 'Search News', hintStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic), border: InputBorder.none),
                  ),
                )
              : Text('News'),
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
            SizedBox(width: 10)
          ],
          bottom: TabBar(
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(57, 255, 255, 255)),
            tabs: [
              Tab(
                text: 'Popular',
              ),
              Tab(text: 'Community')
            ],
            labelStyle: TextStyle(fontSize: 15),
            indicatorWeight: 3,
          ),
        ),
        drawer: MyDrawer(),
        body: TabBarView(children: [FirstTab(), SecondTab()]),
      ),
    );
  }
}
