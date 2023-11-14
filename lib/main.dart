import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/home_binding.dart';
import 'package:myplanet/routes/page_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isUserLoggedIn = await GlobalVariable.userAuth();
  // final initialLocation = isUserLoggedIn ? '/dashboard' : '/login';
  String initialLocation = '/';
  if (isUserLoggedIn) {
    initialLocation = '/dashboard';
  } else {
    initialLocation = '/login';
  }
  HomeBinding().dependencies();

  runApp(MyPlanet(initialLocation: initialLocation));
}

class MyPlanet extends StatelessWidget {
  final String initialLocation;

  const MyPlanet({Key? key, required this.initialLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialLocation,
      getPages: AppPage.pages,
    );
  }
}
