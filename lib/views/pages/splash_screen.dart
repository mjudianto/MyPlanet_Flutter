import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import the router library
import 'package:myplanet/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/home'),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Center(
        child: Container(
          width: 246,
          height: 90,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/splash.png'))),
        ),
      ),
    );
  }
}
