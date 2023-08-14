import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import the router library

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate some async initialization (like fetching data or checking auth)
    Future.delayed(const Duration(seconds: 2), () {
      // After a delay, navigate to the main screen
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
