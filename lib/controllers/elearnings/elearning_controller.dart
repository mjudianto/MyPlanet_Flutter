import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/providers/elearnings/elearning_provider.dart';

class ElearningController {
  static Future<ElearningCourse> fetchUserCourses() async {
    try {
      ElearningCourse userCourses = ElearningCourse();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      userCourses = await ElearningProvider.getUserCourses(userToken ?? "");

      return userCourses;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }
  
}