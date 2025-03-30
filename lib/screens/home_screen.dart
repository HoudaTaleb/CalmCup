import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'product_details_screen.dart';
import 'profil_settings_screen.dart';
import 'about_bakery_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "Coffee";
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();
  bool showInfoBox=true;
  final Map<String, List<Map<String, String>>> allProducts = {
    'Coffee': [
      {'name': 'Latte', 'price': '10', 'image': 'assets/coffee/latte.jpg'},
      {'name': 'Espresso', 'price': '5', 'image': 'assets/coffee/espresso.jpg'},
      {'name': 'Café Mocha', 'price': '15', 'image': 'assets/coffee/mocha.jpg'},
      {'name': 'Macchiato', 'price': '18', 'image': 'assets/coffee/macchiato.jpg'},
      {'name': 'Americano', 'price': '12', 'image': 'assets/coffee/americano.jpg'},
      {'name': 'Cappuccino', 'price': '15', 'image': 'assets/coffee/cappuccino.jpg'},
    ],
    'Tea': [
      {'name': 'Green Tea', 'price': '8', 'image': 'assets/tea/green_tea.jpg'},
      {'name': 'Chai Latte', 'price': '12', 'image': 'assets/tea/herbal.jpg'},
      {'name': 'Black Tea', 'price': '7', 'image': 'assets/tea/black_tea.jpg'},
    ],
    'Pastries': [
      {'name': 'Croissant', 'price': '6', 'image': 'assets/pastries/croissant.jpg'},
      {'name': 'Muffin', 'price': '5', 'image': 'assets/pastries/muffin.jpg'},
      {'name': 'Donut', 'price': '4', 'image': 'assets/pastries/donut.jpg'},
    ],
    'Food': [
      {'name': 'Sandwich', 'price': '12', 'image': 'assets/food/sandwich.jpg'},
      {'name': 'Salad', 'price': '10', 'image': 'assets/food/salad.jpg'},
      {'name': 'Soup', 'price': '8', 'image': 'assets/food/soup.jpg'},
    ],
  };

  List<Map<String, String>> get filteredProducts {
    return allProducts[selectedCategory]!
        .where((product) => product['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF562D13),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/coffee/coffee_background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                color: Colors.black.withOpacity(0.3),
              ),
              Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "COFFEE LOVER",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Your daily coffee needs",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF6D3F2B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Browse your favorite coffee...",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.white70),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.white70),
                            onPressed: () {
                              setState(() {
                                searchQuery = "";
                                searchController.clear();
                              });
                            },
                          )
                              : null,
                        ),
                        onChanged: (query) {
                          setState(() {
                            searchQuery = query;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),

          // Catégories dynamiques
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Coffee', 'Tea', 'Pastries', 'Food']
                  .map((category) => CategoryButton(
                text: category,
                isSelected: selectedCategory == category,
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 20),



          // Produits filtrés en grille
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: filteredProducts[index]['name']!,
                    price: filteredProducts[index]['price']!,
                    image: filteredProducts[index]['image']!,
                  );
                },
              ),
            ),
          ),
          //  Section "À propos de la Bakery"
          if (showInfoBox)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Card(
                color: Color(0xFF3B2310),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0), // Réduction du padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "À propos de CalmCup ☕",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                showInfoBox = false;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 6), // Moins d'espace
                      Text(
                        "Profitez de nos cafés artisanaux et pâtisseries maison. 📍 12 Rue des Cafés, Paris",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 6), // Moins d'espace
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutBakeryScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFDB944B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          ),
                          child: Text("En savoir plus", style: TextStyle(fontSize: 14)),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

// Bouton de catégorie avec état actif
class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryButton({required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFFDB944B) : Colors.grey[700],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}

// Carte de produit avec navigation vers `ProductDetailScreen`
class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  ProductCard({required this.name, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(name: name, price: price, image: image),
          ),
        );
      },
      child: Card(
        color: Color(0xFF302016),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(image, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('\$$price', style: TextStyle(fontSize: 16, color: Color(0xFFDB944B))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
