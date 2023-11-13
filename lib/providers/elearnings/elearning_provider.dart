import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:http/http.dart' as http;
import 'package:myplanet/models/elearnings/elearning_lesson_model.dart';
import 'package:myplanet/models/elearnings/elearning_module_model.dart';
import 'package:myplanet/models/elearnings/elearning_test_model.dart';
import 'package:myplanet/models/elearnings/feedback_question_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_test_record_model.dart';

class ElearningProvider {
  static Future<ElearningCourse> getUserCourses(String userToken) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/getUserCourses'), headers: {
        'Authorization': 'bearer $userToken',
      });
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

  static Future<ElearningCourseDetail> getElearningCourseDetail(String userToken, String elearningCourseId) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/elearningCourseDetail/$elearningCourseId'), headers: {
        'Authorization': 'bearer $userToken',
      });
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

  static Future<ElearningModule> getCourseModules(String userToken, String elearningCourseId) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/getCourseModules/$elearningCourseId'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return elearningModuleFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<ElearningLesson> getModuleLessons(String userToken, String elearningModuleId) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/getModuleLessons/$elearningModuleId'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return elearningLessonFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<UserTestRecord> getModuleTests(String userToken, String elearningModuleId) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/getModuleTests/$elearningModuleId'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return userTestRecordFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<ElearningTest> getTestDetail(String userToken, String elearningTestId) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/getTestDetail/$elearningTestId'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return elearningTestFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<FeedbackQuestion> getFeedbackQuestions(String userToken) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/elearning/feedbackQuestions'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return feedbackQuestionFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
