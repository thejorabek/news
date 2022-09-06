import 'package:flutter/material.dart';
import '../models/news_model.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.searchData}) : super(key: key);
  NewsModel searchData;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: SizedBox(
            width: 260,
            height: 45,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              cursorHeight: 30,
              cursorColor: Colors.white,
              decoration:
                  InputDecoration(contentPadding: EdgeInsets.only(left: 20), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              onChanged: (v) {
                if (controller.text.toLowerCase() == widget.searchData.articles![0].title!.toLowerCase()) {
                  searched.add(widget.searchData.articles![0].title.toString());
                }
              },
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ))
        ],
      ),
      body: ListTile(
        title: Text(searched[0].toString()),
      ),
    );
  }
}

List searched = ['a'];
