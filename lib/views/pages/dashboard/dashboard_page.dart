import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/community/community_page.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_controller.dart';
import 'package:myplanet/views/pages/elearning/elearning_page.dart';
import 'package:myplanet/views/pages/home/home_page.dart';
import 'package:myplanet/views/pages/podtret/podtret_page.dart';
import 'package:myplanet/views/pages/podtret/recomendation_podtret.dart';
import 'package:myplanet/views/pages/profile/profile_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  final _buildBody = <Widget>[
    HomePage(),
    const ElearningPage(),
    const PodtretPage(),
    const CommunityPage(),
    ProfilePage(),
    const RecomendationPodtret()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            body: _buildBody[controller.tabIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              selectedItemColor: blackColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              items: [
                _bottomNavigationBarItem(imagePath: 'assets/icons/ic_home.png', label: 'Home'),
                _bottomNavigationBarItem(imagePath: 'assets/icons/elearning_icon.png', label: 'E-learning'),
                _bottomNavigationBarItem(imagePath: 'assets/icons/ic_podtret_2.png', label: 'Podtret'),
                _bottomNavigationBarItem(imagePath: 'assets/icons/community_icon.png', label: 'Community'),
                _bottomNavigationBarItem(imagePath: '${GlobalVariable.myplanetUrl}/${GlobalVariable.userData['user']['empnik']}', label: 'Profile'),
              ],
            ),
          );
        });
  }

  _bottomNavigationBarItem({required String imagePath, required String label}) {
    return BottomNavigationBarItem(
      icon: Center(
        child: ZoomTapAnimation(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _icon(
                imagePath: imagePath,
                type: label != 'Profile' ? 'asset' : 'network',
                height: label == 'Community' ? 20 : (label == 'Profile' ? 28 : 25),
                status: 'off',
              ),
              SizedBox(
                height: label == 'Community' ? 15 : 10,
              ),
            ],
          ),
        ),
      ),
      activeIcon: Center(
        child: ZoomTapAnimation(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _icon(
                  imagePath: imagePath,
                  type: label != 'Profile' ? 'asset' : 'network',
                  height: label == 'Community' ? 25 : (label == 'Profile' ? 35 : 30),
                  status: 'on'),
              SizedBox(
                height: label == 'Community' ? 15 : (label == 'Profile' ? 5 : 10),
              ),
            ],
          ),
        ),
      ),
      label: label,
    );
  }
}

_icon({required String imagePath, required String type, double? height, required String status}) {
  if (type == 'asset') {
    return Image.asset(
      imagePath,
      color: status == 'off' ? blackColor : primaryColor,
      height: height ?? 25,
      // width: 25,
    );
  }

  if (type == 'network') {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(
          'assets/loading.jpeg', // Placeholder image
          height: 25,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/icons/avatar.png', // Default image for errors
          height: 25,
          fit: BoxFit.cover,
        ),
        imageUrl: imagePath,
        height: height ?? 25,
        fit: BoxFit.cover,
        color: status == 'off' ? blackColor : primaryColor,
      ),
    );
  }
}
