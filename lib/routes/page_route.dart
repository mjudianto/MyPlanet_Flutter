import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/views/pages/community/community_page.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_page.dart';
import 'package:myplanet/views/pages/elearning/elearning_page.dart';
import 'package:myplanet/views/pages/home/home_page.dart';
import 'package:myplanet/views/pages/podtret/podtret_page.dart';
import 'package:myplanet/views/pages/profile/profile_page.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.dashboardPage,
      page: () => DashboardPage(),
    ),
    GetPage(
      name: RouteName.homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: RouteName.elearningPage,
      page: () => const ElearningPage(),
    ),
    GetPage(
      name: RouteName.podtretPage,
      page: () => const PodtretPage(),
    ),
    GetPage(
      name: RouteName.communityPage,
      page: () => const CommunityPage(),
    ),
    GetPage(
      name: RouteName.profilePage,
      page: () => const ProfilePage(),
    ),
  ];
}
