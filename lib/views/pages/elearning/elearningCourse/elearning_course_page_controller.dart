import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/models/elearnings/elearning_lesson_model.dart';
import 'package:myplanet/models/elearnings/elearning_module_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_test_record_model.dart';
import 'package:myplanet/providers/elearnings/elearning_provider.dart';

class ElearningCoursePageController extends GetxController {
  String elearningCourseId = '';

  setElearningCourseId(courseId) => elearningCourseId = courseId;

  Future<ElearningCourseDetail> fetchSingleCourseDetail() async {
    try {
      ElearningCourseDetail courseDetail = ElearningCourseDetail();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      courseDetail = await ElearningProvider.getSingleCourseDetail(userToken ?? "", elearningCourseId);
      return courseDetail;
    } on Exception catch (e) {
      throw Exception('error: $e');
    }
  }

  Future<ElearningModule> fetchCourseModules() async {
    try {
      ElearningModule modules = ElearningModule();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      modules = await ElearningProvider.getCourseModules(userToken ?? "", elearningCourseId);
      return modules;
    } on Exception catch (e) {
      throw Exception('error: $e');
    }
  }

  Future<ElearningLesson> fetchModuleLessons(String elearningModuleId) async {
    try {
      ElearningLesson lessons = ElearningLesson();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      lessons = await ElearningProvider.getModuleLessons(userToken ?? "", elearningModuleId);
      return lessons;
    } on Exception catch (e) {
      throw Exception('error: $e');
    }
  }

  Future<UserTestRecord> fetchModuleTests(String elearningModuleId) async {
    try {
      UserTestRecord tests = UserTestRecord();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      tests = await ElearningProvider.getModuleTests(userToken ?? "", elearningModuleId);
      return tests;
    } on Exception {
      return UserTestRecord();
    }
  }
}
