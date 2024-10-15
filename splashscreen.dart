import 'package:flutter/material.dart';
import 'home.dart'; // Import your home page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(
        const Duration(seconds: 3), () {}); // Delay for 3 seconds
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(), // Replace with your home page
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo.png', // Replace with your logo path
            width: 500, // Desired width
            height: 500, // Desired height
            fit: BoxFit.cover, // Maintain aspect ratio
          ),
        ),
      ),
    );
  }
}
