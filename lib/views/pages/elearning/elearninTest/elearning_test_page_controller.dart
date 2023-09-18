import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_test_model.dart';
import 'package:myplanet/providers/elearnings/elearning_provider.dart';
import 'package:myplanet/providers/elearnings/user_record_provider.dart';

class ElearningTestPageController extends GetxController {
  String elearningTestId = '';
  ElearningTest elearningTest = ElearningTest();
  int passingScore = 0;
  int score = 0;
  String status = 'Lulus';

  void setElearningTestId(testId) {
    elearningTestId = testId.toString();
  }

  Future<ElearningTest> fetchSingleTestDetail() async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      elearningTest = await ElearningProvider.getTestDetail(userToken ?? "", elearningTestId);
      
      return elearningTest;
    } on Exception {
      return elearningTest;
    }
  }

  submitTestRecord(String score) async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      await UserRecordProvider.setUserTestRecord(userToken ?? "", elearningTestId, score);

      // print('sucess');
    } on Exception {
      // print(e);
    }
  }
}