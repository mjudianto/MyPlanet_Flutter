import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/community/community_page.dart';
import 'package:myplanet/views/pages/elearning/elearning_course_page.dart';
import 'package:myplanet/views/pages/elearning/elearning_page.dart';
import 'package:myplanet/views/pages/home_page.dart';
import 'package:myplanet/views/pages/podtret/podtret_page.dart';
import 'package:myplanet/views/pages/profile/profile_page.dart';
import 'package:myplanet/views/pages/splash_screen.dart';
import 'package:myplanet/views/widgets/appBar/bottom_appbar.dart';


void main() {
  runApp(const MyPlanet());
}

class MyPlanet extends StatelessWidget {
  const MyPlanet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "My Planet",
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/elearning',
          builder: (context, state) => const ElearningPage(),
          routes: [
            GoRoute(
              path: 'course/:elearningCourseId',
              builder: (context, state) {
                final elearningCourseId = state.pathParameters['elearningCourseId'];
                return ElearningCoursePage(elearningCourseId: elearningCourseId.toString(),);
              },
            )
          ]
        ),
        GoRoute(
          path: '/podtret',
          builder: (context, state) => const PodtretPage(),
        ),
        GoRoute(
          path: '/community',
          builder: (context, state) => const CommunityPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: child,
          bottomNavigationBar: const MainBottomAppBar(),
        );
      },
    )
  ],
);
