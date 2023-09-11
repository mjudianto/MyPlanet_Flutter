import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/bottomAppBar/bottom_appbar_controller.dart';

class MainBottomAppBar extends GetView<BottomAppBarController> {
  const MainBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(BottomAppBarController());

    return BottomNavigationBar(
      unselectedItemColor: blackColor,
      selectedItemColor: primaryColor,
      onTap: controller.changeTabIndex,
      currentIndex: controller.tabIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          imagePath: 'assets/icons/home_icon.png', 
          label: 'Home'
        ),
        _bottomNavigationBarItem(
          imagePath: 'assets/icons/elearning_icon.png', 
          label: 'Elearning'
        ),
        _bottomNavigationBarItem(
          imagePath: 'assets/icons/podtret_icon.png', 
          label: 'Podtret'
        ),
        _bottomNavigationBarItem(
          imagePath: 'assets/icons/community_icon.png', 
          label: 'Community'
        ),
        _bottomNavigationBarItem(
          imagePath: 'assets/icons/home_icon.png', 
          label: 'Profile'
        ),
      ],
    );
  }

  _bottomNavigationBarItem({required String imagePath, required String label}) {
    return BottomNavigationBarItem(
      icon: IconButton(
        splashColor: Colors.transparent,  
        highlightColor: Colors.transparent,
        icon: Image.asset(
          imagePath,
          color: blackColor,
          height: 25,
        ),
        onPressed: () {
        },
      ),
      label: label
    );
  }

}
