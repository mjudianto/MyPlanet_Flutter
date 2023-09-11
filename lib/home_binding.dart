
import 'package:get/get.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_controller.dart';

class HomeBinding implements Bindings {
  @override

  void dependencies() {
    Get.put<DashboardController>(DashboardController(), permanent: true);
  }
}