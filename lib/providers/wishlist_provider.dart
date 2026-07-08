import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistProvider extends ChangeNotifier {
  static const _key = "wishlist";

  final List<String> _ids = [];

  List<String> get ids => _ids;

  bool isFavorite(String id) {
    return _ids.contains(id);
  }

  Future<void> loadWishlist() async {
    final pref = await SharedPreferences.getInstance();

    final data = pref.getStringList(_key) ?? [];

    _ids
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  Future<void> toggle(String id) async {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }

    final pref = await SharedPreferences.getInstance();

    await pref.setStringList(_key, _ids);

    notifyListeners();
  }
}