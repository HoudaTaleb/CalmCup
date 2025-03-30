import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_calm/providers/order_provider.dart';
import 'package:coffee_calm/providers/favorite_provider.dart';
import 'package:coffee_calm/screens/splash_screen.dart';
import 'package:coffee_calm/providers/auth_service.dart';
import 'package:coffee_calm/providers/review_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (_) => OrderProvider()), // ✅ Order Management
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),// ✅ Favorite System
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoffeeShop App',
      home: SplashScreen(),
    );
  }
}
