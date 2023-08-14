import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';

class ElearningCoursePage extends StatefulWidget {
  const ElearningCoursePage({super.key, required this.elearningCourseId});

  final String elearningCourseId;

  @override
  State<ElearningCoursePage> createState() => _ElearningCoursePageState();
}

class _ElearningCoursePageState extends State<ElearningCoursePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  // Place your media player here
                  Positioned.fill(
                    child: Container(
                      color: blackColor, // Placeholder color, replace with your video player
                    ),
                  ),
                  // Back button at the top left
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      color: whiteColor,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
