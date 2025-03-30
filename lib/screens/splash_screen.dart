import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signin_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(seconds: 1), vsync: this)..repeat();
    _dotsAnimation = IntTween(begin: 0, end: 3).animate(_controller);

    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image de fond
          Image.asset(
            'assets/splash_bg.jpg',
            fit: BoxFit.cover,
          ),
          // Superposition sombre
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Contenu principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Text(
                  'CalmCup',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),

                AnimatedBuilder(
                  animation: _dotsAnimation,
                  builder: (context, child) {
                    String dots = '.' * (_dotsAnimation.value % 4); // Variation de "." à "..."
                    return Text(
                      'Loading$dots',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
