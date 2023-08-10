import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/providers/elearnings/elearning_course_provider.dart';

class ElearningCourseController {
  static Future<ElearningCourse> fetchUserCourses() async {
    try {
      ElearningCourse userCourses = ElearningCourse();
      userCourses = await ElearningCourseProvider.getUserCourses("230100040");
      // userCourses.data[0].progress = 50%;  
      return userCourses;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }
}