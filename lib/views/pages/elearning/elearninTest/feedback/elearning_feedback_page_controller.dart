import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/feedback_question_model.dart';
import 'package:myplanet/providers/elearnings/elearning_provider.dart';
import 'package:myplanet/providers/elearnings/user_record_provider.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';

class ElearningFeedbackPageController extends GetxController {
  RxBool feedbackSent = true.obs;
  RxBool testPassed = false.obs;
  
  ElearningTestPageController elearningTestPageController = Get.find();

  checkExistingUserFeedback(String elearningTestId) async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      feedbackSent.value = await UserRecordProvider.checkExistingUserFeedback(userToken ?? "", elearningTestId);
    } on Exception {
      rethrow;
    }
  }

  Future<FeedbackQuestion> fetchFeedbackQuestion() async {
    try {
      FeedbackQuestion feedbackQuestion = FeedbackQuestion();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      feedbackQuestion = await ElearningProvider.getFeedbackQuestions(userToken ?? "");

      return feedbackQuestion;
    } catch (e) {
      rethrow;
    }
  }

  sendUserFeedback(List<Map> feedbacks) async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      await UserRecordProvider.sendUserFeedback(userToken ?? "", elearningTestPageController.elearningTestId, feedbacks);
    } catch (e) {
      // print(e);
    }
  }
}