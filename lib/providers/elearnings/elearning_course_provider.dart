import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:http/http.dart' as http;

class ElearningCourseProvider {
  static const String baseUrl = "https://myplanet.enseval.com:3000/elearningCourses"; // Replace with your API base URL

  static Future<ElearningCourse> getUserCourses(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getUserCourses/$userId'));
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

  static Future<ElearningCourseDetail> getSingleCourseDetail(String elearningCourseId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getSingleCourseDetail/$elearningCourseId'));
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return elearningCourseDetailFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


