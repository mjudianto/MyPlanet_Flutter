import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/views/pages/elearning/elearning_page.dart';
// import 'package:myplanet/views/pages/elearning/elearning_page.dart';
import 'package:myplanet/views/pages/home_page.dart';
import 'package:myplanet/views/widgets/appBar/bottom_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  initialLocation: '/',
  routes: [
    ShellRoute(
      routes: [ 
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/elearning',
          builder: (context, state) => const ElearningPage(),
        ),
      ],

      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const CustomBottomAppBar(
            currentLocation: '/',
          ),
        );
      },
    )
    
  ],
);
