import 'package:myplanet/helpers/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:myplanet/models/elearnings/userRecords/user_post_test_access_request_model.dart';

class UserRecordProvider {
  static setUserLessonRecord(String userToken, String elearningLessonId) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/setUserLessonRecord'),
        headers: {
          'Authorization' : 'bearer $userToken',
        },
        body: {
          'elearningLessonId' : elearningLessonId
        },
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
          'Authorization' : 'bearer $userToken',
        },
        body: {
          'elearningTestId' : elearningTestId,
          'score' : score
        },
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
          'Authorization' : 'bearer $userToken',
        },
        body: {
          'elearningTestId' : elearningTestId,
          'message' : message
        },
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
          'Authorization' : 'bearer $userToken',
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

  static Future<UserPostTestAccessRequest> checkExistingUserFeedback(String userToken, String elearningTestId) async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/checkExistingUserPostTestAccessRequest/$elearningTestId'),
        headers: {
          'Authorization' : 'bearer $userToken',
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

}


