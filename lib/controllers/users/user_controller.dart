import 'package:myplanet/models/users/user_model.dart';
import 'package:myplanet/providers/users/user_provider.dart';

class UserController {
  static Future<User> fetchUserToken(String userNik, String password) async {
    try {
      User userToken = User();
      userToken = await UserProvider.userAuth(userNik, password);
      return userToken;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }
}