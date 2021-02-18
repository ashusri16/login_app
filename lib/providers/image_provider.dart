import 'package:flutter/widgets.dart';

class ImageProvider extends ChangeNotifier {
  String currentStatus = "initial";
  void loading() {
    currentStatus = 'loading';
    notifyListeners();
  }

  void loaded() {
    currentStatus = 'loaded';
    notifyListeners();
  }

  void error() {
    currentStatus = 'error';
    notifyListeners();
  }
}
