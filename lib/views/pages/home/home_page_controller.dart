
import 'package:get/get.dart';
import 'package:myplanet/controllers/elearnings/elearning_controller.dart';
import 'package:myplanet/controllers/podtrets/podtret_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/models/podtrets/podtret_model.dart';

class HomePageController extends GetxController {
  final Future<ElearningCourse> userCoursesFuture = ElearningController.fetchUserCourses();
  final Future<Podtret> newPodtrets = PodtretController.fetchNewPodtrets();
  final Future<bool> checkInternetConnection = GlobalVariable.checkInternetConnection();
}