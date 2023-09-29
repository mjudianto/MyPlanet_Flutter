import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
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
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/splash.png'))),
        ),
      ),
    );
  }
}
