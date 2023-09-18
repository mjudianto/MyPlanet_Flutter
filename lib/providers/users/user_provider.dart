import 'package:myplanet/helpers/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:myplanet/models/users/user_model.dart';

class UserProvider {
  static Future<User> userAuth(String userNik, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/users/userLogin'),
        body: {
          'userNik' : userNik,
          'password' : password
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return userFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }

    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


