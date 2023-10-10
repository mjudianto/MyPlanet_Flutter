import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/views/pages/community/community_page.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_page.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/feedback/elearning_feedback_page.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page.dart';
import 'package:myplanet/views/pages/elearning/elearning_page.dart';
import 'package:myplanet/views/pages/home/home_page.dart';
import 'package:myplanet/views/pages/login_page.dart';
import 'package:myplanet/views/pages/podtret/new_eps_podtret.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_page.dart';
import 'package:myplanet/views/pages/podtret/podtret_page.dart';
import 'package:myplanet/views/pages/podtret/recomendation_podtret.dart';
import 'package:myplanet/views/pages/podtret/top_eps_podtret.dart';
import 'package:myplanet/views/pages/profile/account_info.dart';
import 'package:myplanet/views/pages/profile/mandatory/mandatory_page.dart';
import 'package:myplanet/views/pages/profile/profile_page.dart';
import 'package:myplanet/views/pages/splash_screen.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteName.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteName.dashboardPage,
      page: () => DashboardPage(),
    ),
    GetPage(
      name: RouteName.homePage,
      page: () => HomePage(),
    ),

    // elearning
    GetPage(
      name: RouteName.elearningPage,
      page: () => const ElearningPage(),
    ),
    GetPage(
      name: RouteName.elearningCoursePage,
      page: () => const ElearningCoursePage(),
    ),
    GetPage(
      name: RouteName.elearningTestPage,
      page: () => const ElearningTestPage(),
    ),
    GetPage(
      name: RouteName.elearningFeedbackPage,
      page: () => ElearningFeedbackPage(),
    ),


    // podtret 
    GetPage(
      name: RouteName.podtretPage,
      page: () => const PodtretPage(),
    ),
    GetPage(
      name: RouteName.recomendationPodtret,
      page: () => const RecomendationPodtret(),
    ),
    GetPage(
      name: RouteName.newEpisodePodtret,
      page: () => const NewEpsPodtret(),
    ),
    GetPage(
      name: RouteName.topEpisodePodtret,
      page: () => const TopEpsPodtret(),
    ),
    GetPage(
      name: RouteName.podtretContent,
      page: () => PodtretContent(),
    ),


    GetPage(
      name: RouteName.communityPage,
      page: () => const CommunityPage(),
    ),

    // profile  
    GetPage(
      name: RouteName.profilePage,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: RouteName.accountInfo,
      page: () => const AccountInfo(),
    ),
    GetPage(
      name: RouteName.mandatoryPage,
      page: () => const Mandatory(),
    ),
  ];
}
