import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get favorites => _favorites;

  void toggleFavorite(String name, String price, String image) {
    final existingIndex = _favorites.indexWhere((item) => item["name"] == name);
    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex); // ✅ Retirer des favoris si déjà ajouté
    } else {
      _favorites.add({"name": name, "price": price, "image": image});
    }
    notifyListeners(); // ✅ Informe les widgets que l'état a changé
  }

  bool isFavorite(String name) {
    return _favorites.any((item) => item["name"] == name);
  }
}
