import 'package:flutter/widgets.dart';

class NotificationProvider extends ChangeNotifier {
  bool _disabled = false;

  bool get disabled => _disabled;

  void enabled() {
    _disabled = !_disabled;
    notifyListeners();
  }
}
