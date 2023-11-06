import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';

class FirstExample extends StatefulWidget {
  const FirstExample({super.key});

  @override
  State<FirstExample> createState() => _FirstExampleState();
}

class _FirstExampleState extends State<FirstExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 8,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                borderColor: pastelSecondaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                borderWidth: 1,
                unselectedBorderColor: pastelSecondaryColor,
                backgroundColor: primaryColor,
                unselectedBackgroundColor: whiteColor,
                unselectedLabelStyle: const TextStyle(color: blackColor),
                radius: 100,
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "General",
                  ),
                  Tab(
                    text: "QA & Security",
                  ),
                  Tab(
                    text: "Technical",
                  ),
                  Tab(
                    text: "Soft Skill",
                  ),
                  Tab(
                    text: "SOP IK",
                  ),
                  Tab(
                    text: "InnoChamp",
                  ),
                  Tab(
                    text: "Enseval Bootcamp",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: Text("ea"),
                    ),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                    Center(
                      child: Icon(Icons.directions_bike),
                    ),
                    Center(
                      child: Icon(Icons.directions_car),
                    ),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                    Center(
                      child: Icon(Icons.directions_bike),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
