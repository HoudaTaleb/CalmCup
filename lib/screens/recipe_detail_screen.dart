import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String ingredients;
  final String steps;

  RecipeDetailScreen({required this.name, required this.image, required this.ingredients, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(image, width: 200, height: 250, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Ingredients:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              ingredients,
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Preparation Steps:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  steps,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
