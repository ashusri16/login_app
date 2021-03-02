import 'package:flutter/widgets.dart';

class SizeProvider extends ChangeNotifier {
  static var defaultSizeProvider = SizeProvider();
  double fontSize = 18;

  incSize() {
    if (fontSize < 28) {
      fontSize += 2;
      notifyListeners();
    }
  }

  decSize() {
    if (fontSize > 12) {
      fontSize -= 2;
      notifyListeners();
    }
  }
}
