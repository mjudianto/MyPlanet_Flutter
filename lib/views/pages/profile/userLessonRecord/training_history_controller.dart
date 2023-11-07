import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/userRecords/user_lesson_record_model.dart';
import 'package:myplanet/providers/elearnings/user_record_provider.dart';

class TrainingHistoryPageController extends GetxController {
  Future<UserLessonRecord?> fetchUserLessonRecord() async {
    try {
      UserLessonRecord userLessonRecord = UserLessonRecord();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      userLessonRecord = await UserRecordProvider.getUserLessonRecord(userToken ?? "");

      return userLessonRecord;
    } catch (e) {
      return null;
      // print(e);
    }
  }
}
