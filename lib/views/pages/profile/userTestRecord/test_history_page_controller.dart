import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/userRecords/user_test_history_model.dart';
import 'package:myplanet/providers/elearnings/user_record_provider.dart';

class TestHistoryPageController extends GetxController {
  Future<UserTestHistory?> fetchUserTestRecord() async {
    try {
      UserTestHistory userTestRecord = UserTestHistory();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      userTestRecord = await UserRecordProvider.getUserTestRecord(userToken ?? "");

      return userTestRecord;
    } catch (e) {
      return null;
      // print(e);
    }
  }
}
