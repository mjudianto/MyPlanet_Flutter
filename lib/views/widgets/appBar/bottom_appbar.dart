import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/theme.dart';
// import 'package:myplanet/views/pages/elearning/elearning_page.dart';
// import 'package:myplanet/views/pages/home_page.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String currentLocation;

  const CustomBottomAppBar({Key? key, required this.currentLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildTabItem(context, 'assets/icons/home_icon.png', "Home", '/'),
          buildTabItem(context, 'assets/icons/elearning_icon.png', "E-Learning", '/elearning'),
          // buildTabItem('assets/icons/podtret_icon.png', "Podtret", 2, PodcastPage()),
          // buildTabItem('assets/icons/community_icon.png', "Community", 3, CommunityPage()),
          // buildTabItem('assets/icons/home_icon.png', "Profile", 4, ProfilePage()),
        ],
      ),
    );
  }

  Widget buildTabItem(BuildContext context, String imagePath, String text, String url) {
    final isActive = currentLocation == url;
    
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          IconButton(
            icon: Image.asset(
              imagePath,
              color: isActive ? primaryColor : blackColor,
              height: 25,
            ),
            onPressed: () {
              context.go(url.toString());
            },
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
