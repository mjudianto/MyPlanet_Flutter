import 'package:myplanet/helpers/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:myplanet/models/users/user_model.dart';

class UserProvider {
  static Future<User> userAuth(String userNik, String password) async {
    try {
      final client = await GlobalVariable.getSSLPinningClient();

      final response = await client.post(
        Uri.parse('${GlobalVariable.apiUrl}/users/userLogin'),
        body: {'userNik': userNik, 'password': password},
      );

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return userFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      // print(e);
      throw Exception('Error: $e');
    }
  }

  static changeUserPassword(String? userToken, String oldPassword, String newPassword) async {
    try {
      final response = await http.put(Uri.parse('${GlobalVariable.apiUrl}/users/changePassword'), headers: {
        'Authorization': 'bearer $userToken',
      }, body: {
        'oldPassword': oldPassword,
        'newPassword': newPassword
      });
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
        // throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      // print(e);
      return 'failed';
    }
  }

  // forgotPassword
  static Future<String> forgotPassword(String userNik) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/users/forgotPassword'),
        body: {'userNik': userNik},
      );

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return jsonResponse;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      // print(e);
      throw Exception('Error: $e');
    }
  }
}
