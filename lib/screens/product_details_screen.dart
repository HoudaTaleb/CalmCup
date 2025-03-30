import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipe_detail_screen.dart';
import 'order_confirmation_screen.dart';
import 'bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffee_calm/providers/favorite_provider.dart';
import 'package:coffee_calm/providers/review_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  ProductDetailScreen({required this.name, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
              bool isFav = favoriteProvider.isFavorite(name);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Color(0xFFDB944B) : Colors.white,
                ),
                onPressed: () {
                  favoriteProvider.toggleFavorite(name, price, image);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(image, width: double.infinity, height: 250, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 5),
                  Text("With Oat Milk", style: TextStyle(fontSize: 16, color: Colors.grey[400])),
                  SizedBox(height: 10),

                  // Affichage de la moyenne des notes
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Text(
                        " ${reviewProvider.getAverageRating(name).toStringAsFixed(1)} ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "(${reviewProvider.reviews[name]?.length ?? 0} reviews)",
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Description du produit
                  Text("Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 5),
                  Text(
                    "This $name is known to be particularly rich and creamy, perfect for any time of the day.",
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                  SizedBox(height: 20),


                  Text("Customer Reviews",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 10),
                  _buildReviewsList(context, name),

                  _buildReviewForm(context, name),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$$price",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFDB944B))),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderConfirmationScreen(
                                productName: name,
                                productPrice: price,
                                productImage: image,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFDB944B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: Text("Buy Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildReviewsList(BuildContext context, String productName) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final reviews = reviewProvider.reviews[productName] ?? [];

    return reviews.isEmpty
        ? Text("No reviews yet.", style: TextStyle(color: Colors.grey))
        : Column(
      children: reviews.map((review) {
        return Card(
          color: Color(0xFF3B2310),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(review.user, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(review.comment, style: TextStyle(color: Colors.grey[400])),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(review.rating, (index) => Icon(Icons.star, color: Colors.yellow, size: 16)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReviewForm(BuildContext context, String productName) {
    final TextEditingController commentController = TextEditingController();
    ValueNotifier<int> selectedRating = ValueNotifier<int>(0);
    String firstName = "User"; // Valeur par défaut


    SharedPreferences.getInstance().then((prefs) {
      firstName = prefs.getString('firstName') ?? "User";
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Leave a Review", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),

        ValueListenableBuilder<int>(
          valueListenable: selectedRating,
          builder: (context, rating, child) {
            return Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(Icons.star, color: index < rating ? Colors.yellow : Colors.grey),
                  onPressed: () {
                    selectedRating.value = index + 1;
                  },
                );
              }),
            );
          },
        ),

        TextField(
          controller: commentController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Write your review...",
            labelStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Color(0xFF3B2310),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            if (commentController.text.isNotEmpty && selectedRating.value > 0) {
              Provider.of<ReviewProvider>(context, listen: false)
                  .addReview(productName, firstName, selectedRating.value, commentController.text);
              commentController.clear();
              selectedRating.value = 0;
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDB944B)),
          child: Text("Submit Review", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

}
