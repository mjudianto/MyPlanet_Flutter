import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';

class MainBottomAppBar extends StatefulWidget {
  const MainBottomAppBar({Key? key})
      : super(key: key);

  @override
  State<MainBottomAppBar> createState() => _MainBottomAppBarState();
}

class _MainBottomAppBarState extends State<MainBottomAppBar> {
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildTabItem(context, 'assets/icons/home_icon.png', "Home", '/home'),
          buildTabItem(context, 'assets/icons/elearning_icon.png', "E-Learning", '/elearning'),
          buildTabItem(context, 'assets/icons/podtret_icon.png', "Podtret", '/podtret'),
          buildTabItem(context, 'assets/icons/community_icon.png', "Community", '/community'),
          buildTabItem(context, 'assets/icons/home_icon.png', "Profile", '/profile'),
        ],
      ),
    );
  }

  Widget buildTabItem(BuildContext context, String imagePath, String text, String url) {
    final isActive = GlobalVariable.currentUrl == '' ? url == '/home' : GlobalVariable.currentUrl == url;
    
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
              setState(() {
                GlobalVariable.currentUrl = url;
              });
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
