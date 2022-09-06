import 'package:book/main.dart';
import 'package:book/models/news_model.dart';
import 'package:flutter/widgets.dart';

class BookmarkProvider extends ChangeNotifier {
  List _bookMark = [];
  bool _isBookmarked = true;

  bool get isBookmarked => _isBookmarked;

  List get bookMark => _bookMark;

  void addToBookmark(Article news) {
    _bookMark.add(news);
    box.write('bookmarks', bookMark);
    notifyListeners();
  }

  void toBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }
}
