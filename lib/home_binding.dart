
import 'package:get/get.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_controller.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/feedback/elearning_feedback_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';
import 'package:myplanet/views/pages/profile/profile_page_controller.dart';
import 'package:myplanet/views/widgets/carousel/carouselPodtret/carousel_podtret_controller.dart';

class HomeBinding implements Bindings {
  @override

  void dependencies() {
    Get.put<DashboardController>(DashboardController(), permanent: true);

    // elearning 
    Get.put<ElearningCoursePageController>(ElearningCoursePageController(), permanent: true);
    Get.put<ElearningTestPageController>(ElearningTestPageController(), permanent: true);
    Get.put<ElearningFeedbackPageController>(ElearningFeedbackPageController(), permanent: true);

    //podtret
    Get.put<ImageSliderController>(ImageSliderController(), permanent: true);
    Get.put<PodtretKontenController>(PodtretKontenController(), permanent: true);

    Get.put<HomePageController>(HomePageController(), permanent: true);

    Get.put<ProfilePageController>(ProfilePageController(), permanent: true);
  }
}