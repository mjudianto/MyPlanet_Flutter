
import 'package:get/get.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_controller.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';

class HomeBinding implements Bindings {
  @override

  void dependencies() {
    Get.put<DashboardController>(DashboardController(), permanent: true);
    
    Get.put<HomePageController>(HomePageController(), permanent: true);

    // elearning 
    Get.put<ElearningCoursePageController>(ElearningCoursePageController(), permanent: true);
    Get.put<ElearningTestPageController>(ElearningTestPageController(), permanent: true);
  }
}