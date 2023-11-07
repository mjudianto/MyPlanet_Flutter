import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/userRecords/user_post_test_access_request_model.dart';
import 'package:myplanet/providers/elearnings/user_record_provider.dart';

class UserRecordController {
  static setUserLessonRecord(String elearningLessonId) async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      await UserRecordProvider.setUserLessonRecord(userToken ?? "", elearningLessonId);

      return "success";
    } on Exception catch (e) {
      return e;
    }
  }

  static sendUserPostTestAccessRequest(String elearningTestId, String message) async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      await UserRecordProvider.sendUserPostTestAccessRequest(userToken ?? "", elearningTestId, message);

      return "success";
    } on Exception catch (e) {
      return e;
    }
  }

  static Future<UserPostTestAccessRequest> checkExistingUserPostTestAccessRequest(String elearningTestId) async {
    UserPostTestAccessRequest userPostTestAccessRequest = UserPostTestAccessRequest();

    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      userPostTestAccessRequest = await UserRecordProvider.checkExistingUserPostTestAccessRequest(userToken ?? "", elearningTestId);

      return userPostTestAccessRequest;
    } on Exception {
      return UserPostTestAccessRequest();
    }
  }
}
