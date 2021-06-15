import 'package:flutter/material.dart';

class CardLastFourProvider with ChangeNotifier {
  var _cardLastFour;

  CardLastFourProvider(initValue) {
    _cardLastFour = initValue;
  }

  void setLastFour(String cvv) {
    _cardLastFour = cvv;
    notifyListeners();
  }

  get cardLastFour => _cardLastFour;
}
