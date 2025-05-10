import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int itemCount = 0;

  void addItem() {
    itemCount++;
    notifyListeners();
  }

  void clearCart() {
    itemCount = 0;
    notifyListeners();
  }
}
