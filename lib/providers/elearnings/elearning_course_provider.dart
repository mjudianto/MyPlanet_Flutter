import '../../models/elearnings/elearning_course_model.dart';
import 'package:http/http.dart' as http;

class ElearningCourseProvider {
  static const String baseUrl = "https://myplanet.enseval.com:3000"; // Replace with your API base URL

  static Future<ElearningCourse> getUserCourses(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/elearningCourses/getUserCourses/$userId'));
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return elearningCourseFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


