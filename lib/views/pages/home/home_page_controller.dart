import 'package:get/get.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/models/podtrets/podtret_model.dart';

class HomePageController extends GetxController {
  late Future<ElearningCourse> userCoursesFuture;
  late Future<Podtret> newPodtrets;
}
