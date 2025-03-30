import 'package:coffee_calm/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav_bar.dart';
import 'favorites_screen.dart';
import 'package:coffee_calm/providers/auth_service.dart';

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  String firstName = "User"; // Valeur par défaut

  @override
  void initState() {
    super.initState();
    _loadFirstName();
  }

  void _loadFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello, $firstName!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 25,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Account Section
            _buildSectionTitle("Account"),
            _buildProfileOption("Account details", Icons.person),
            _buildProfileOption("Payment details", Icons.payment),
            _buildProfileOption("Notification settings", Icons.notifications),

            // Orders Section
            _buildSectionTitle("Orders"),
            _buildProfileOption("Order history", Icons.history),
            _buildProfileOption("Rewards and Loyalty", Icons.card_giftcard),

            // Recipes Section
            _buildSectionTitle("Recipes"),
            _buildProfileOption("Recipes saved", Icons.receipt_long),

            // Library Section
            _buildSectionTitle("Library"),
            _buildProfileOption("Books", Icons.menu_book),

            _buildSectionTitle("Favorites"),
            _buildProfileOption("My Favorites", Icons.favorite, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            }),

            // Settings Section
            _buildSectionTitle("Settings"),
            _buildProfileOption("Security settings", Icons.security),
            _buildProfileOption("App settings", Icons.settings),

            // Support Section
            _buildSectionTitle("Support"),
            _buildProfileOption("Help and support", Icons.help_outline),

            _buildSectionTitle("LogOut"),
            _buildProfileOption("LogOut", Icons.logout, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Profile Option Button with onTap Functionality
  Widget _buildProfileOption(String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFF6D3F2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        onTap: onTap,
      ),
    );
  }
}
