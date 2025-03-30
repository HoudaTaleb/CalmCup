import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_calm/providers/favorite_provider.dart';
import 'product_details_screen.dart';
import 'bottom_nav_bar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoriteProvider.favorites;

    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text("Favorites" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites yet.", style: TextStyle(color: Colors.white, fontSize: 18)))
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final fav = favorites[index];
          return ListTile(
            leading: Image.asset(fav["image"]!, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(fav["name"]!, style: TextStyle(color: Colors.white)),
            subtitle: Text("\$${fav["price"]}", style: TextStyle(color: Colors.orange)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    name: fav["name"]!,
                    price: fav["price"]!,
                    image: fav["image"]!,
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
