import 'package:flutter/material.dart';

class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

class Cart with ChangeNotifier {
  List<ShopItem> _items = [];

  List<ShopItem> get items => _items;

  void addItem(ShopItem item) {
    _items.add(item);
    notifyListeners();
  }
}
