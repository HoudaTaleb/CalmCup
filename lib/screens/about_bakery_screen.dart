import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class AboutBakeryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text("À propos de CalmCup"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image d'illustration
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/about_bakery.jpg", fit: BoxFit.cover),
            ),
            SizedBox(height: 20),

            // Titre et historique
            Text(
              "Notre Histoire 🏡",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "Depuis 1998, CalmCup propose des cafés artisanaux et des pâtisseries faites maison avec amour. Nous utilisons des ingrédients locaux et des recettes traditionnelles pour offrir des saveurs uniques à nos clients.",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 20),

            // Engagement de la marque
            Text(
              "Notre Engagement 🌱",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "Nous privilégions le commerce équitable et les produits bio pour garantir une qualité exceptionnelle tout en respectant l’environnement.",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 20),

            // Adresse et contact
            Text(
              "📍 Nos Adresses",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "✔ 12 Rue des Cafés, Paris\n✔ 45 Avenue du Thé, Lyon\n✔ 78 Place du Mocha, Marseille",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 20),

            // Contact
            Text(
              "📞 Contact",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "📧 contact@calmcup.com\n📞 +33 1 23 45 67 89",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
