import 'dart:convert';

import 'package:myplanet/helpers/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:myplanet/models/elearnings/userRecords/user_lesson_record_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_post_test_access_request_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_test_history_model.dart';

class UserRecordProvider {
  static setUserLessonRecord(String userToken, String elearningLessonId) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/setUserLessonRecord'),
        headers: {
          'Authorization': 'bearer $userToken',
        },
        body: {'elearningLessonId': elearningLessonId},
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return jsonResponse;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static setUserTestRecord(String userToken, String elearningTestId, String score) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/setUserTestRecord'),
        headers: {
          'Authorization': 'bearer $userToken',
        },
        body: {'elearningTestId': elearningTestId, 'score': score},
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return jsonResponse;
      } else {
        throw Exception('${response.statusCode} Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static sendUserPostTestAccessRequest(String userToken, String elearningTestId, String message) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/sendPostTestAccessRequest'),
        headers: {
          'Authorization': 'bearer $userToken',
        },
        body: {'elearningTestId': elearningTestId, 'message': message},
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return jsonResponse;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<UserPostTestAccessRequest> checkExistingUserPostTestAccessRequest(String userToken, String elearningTestId) async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/checkExistingUserPostTestAccessRequest/$elearningTestId'),
        headers: {
          'Authorization': 'bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return userPostTestAccessRequestFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static checkExistingUserFeedback(String userToken, String elearningTestId) async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/checkExistingUserFeedback/$elearningTestId'),
        headers: {
          'Authorization': 'bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
        // throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static sendUserFeedback(String userToken, String elearningTestId, List<Map> feedbacks) async {
    try {
      String jsonFeedback = json.encode(feedbacks);
      final response = await http.post(Uri.parse('${GlobalVariable.apiUrl}/userRecords/userFeedback/$elearningTestId'), headers: {
        'Authorization': 'bearer $userToken',
      }, body: {
        'feedbacks': jsonFeedback
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        // print(response.body);
        // throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      // print(e);
      throw Exception('Error: $e');
    }
  }

  static Future<UserLessonRecord> getUserLessonRecord(String userToken) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/userRecords/userLessonRecord'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return userLessonRecordFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      // print(e);
      throw Exception('Error: $e');
    }
  }

  static Future<UserTestHistory> getUserTestRecord(String userToken) async {
    try {
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/userRecords/userTestRecord'), headers: {
        'Authorization': 'bearer $userToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return userTestHistoryFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      // print(e);
      throw Exception('Error: $e');
    }
  }
}
