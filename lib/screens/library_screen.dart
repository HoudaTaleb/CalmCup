import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'book_detail_screen.dart';
import 'recipe_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Library", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFFDB944B),
          labelColor: Color(0xFFDB944B),
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Books"),
            Tab(text: "Recipes"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BookList(),
          RecipeList(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BookList extends StatelessWidget {
  final List<Map<String, String>> books = [
    {
      "title": "The Art of Coffee",
      "image": "assets/books/book1.jpg",
      "description": "A guide to coffee making.",
      "content": "This book explores the history and science behind making the perfect cup of coffee..."
    },
    {
      "title": "Barista Handbook",
      "image": "assets/books/book2.jpg",
      "description": "Everything about brewing coffee.",
      "content": "Discover expert barista techniques, from espresso pulling to latte art..."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(books[index]['image'] ?? "", width: 50, height: 50, fit: BoxFit.cover),
          title: Text(books[index]['title'] ?? "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(books[index]['description'] ?? "", style: TextStyle(color: Colors.grey)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(
                  title: books[index]["title"] ?? "",
                  image: books[index]["image"] ?? "",
                  description: books[index]["description"] ?? "",
                  content: books[index]["content"] ?? "",
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<Map<String, String>> recipes = [
    {
      "name": "Tiramisu",
      "image": "assets/pastries/tiramisu.jpg",
      "ingredients": "Eggs, Sugar, Coffee, Mascarpone, Cocoa Powder",
      "steps": "1. Prepare the coffee...\n2. Mix mascarpone and eggs...\n3. Layer the dessert..."
    },
    {
      "name": "Espresso",
      "image": "assets/coffee/Espresso.jpg",
      "ingredients": "Coffee Beans, Water",
      "steps": "1. Grind the coffee...\n2. Brew under pressure...\n3. Serve immediately..."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(recipes[index]['image'] ?? "", width: 50, height: 50, fit: BoxFit.cover),
          title: Text(recipes[index]['name'] ?? "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  name: recipes[index]["name"] ?? "",
                  image: recipes[index]["image"] ?? "",
                  ingredients: recipes[index]["ingredients"] ?? "",
                  steps: recipes[index]["steps"] ?? "",
                ),
              ),
            );
          },
        );
      },
    );
  }
}
