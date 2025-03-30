import 'package:flutter/material.dart';

class Review {
  final String user;
  final int rating;
  final String comment;

  Review({required this.user, required this.rating, required this.comment});
}

class ReviewProvider extends ChangeNotifier {
  final Map<String, List<Review>> _reviews = {}; // Stocker les avis par produit

  Map<String, List<Review>> get reviews => _reviews;

  void addReview(String productName, String user, int rating, String comment) {
    if (!_reviews.containsKey(productName)) {
      _reviews[productName] = [];
    }
    _reviews[productName]!.add(Review(user: user, rating: rating, comment: comment));
    notifyListeners();
  }

  double getAverageRating(String productName) {
    if (!_reviews.containsKey(productName) || _reviews[productName]!.isEmpty) {
      return 0;
    }
    double total = _reviews[productName]!.fold(0, (sum, item) => sum + item.rating);
    return total / _reviews[productName]!.length;
  }
}
