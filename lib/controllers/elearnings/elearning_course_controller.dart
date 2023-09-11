import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/models/elearnings/elearning_lesson_model.dart';
import 'package:myplanet/models/elearnings/elearning_module_model.dart';
import 'package:myplanet/models/elearnings/elearning_test_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_test_record_model.dart';
import 'package:myplanet/providers/elearnings/elearning_course_provider.dart';

class ElearningCourseController {
  static Future<ElearningCourse> fetchUserCourses() async {
    try {
      ElearningCourse userCourses = ElearningCourse();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      userCourses = await ElearningCourseProvider.getUserCourses(userToken ?? "");

      return userCourses;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }

  static Future<ElearningCourseDetail> fetchSingleCourseDetail(String elearningCourseId) async {
    try {
      ElearningCourseDetail courseDetail = ElearningCourseDetail();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      courseDetail = await ElearningCourseProvider.getSingleCourseDetail(userToken ?? "", elearningCourseId);
      return courseDetail;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }

  static Future<ElearningModule> fetchCourseModules(String elearningCourseId) async {
    try {
      ElearningModule modules = ElearningModule();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      modules = await ElearningCourseProvider.getCourseModules(userToken ?? "", elearningCourseId);
      return modules;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }

  static Future<ElearningLesson> fetchModuleLessons(String elearningModuleId) async {
    try {
      ElearningLesson lessons = ElearningLesson();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      lessons = await ElearningCourseProvider.getModuleLessons(userToken ?? "", elearningModuleId);
      return lessons;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }

  static Future<UserTestRecord> fetchModuleTests(String elearningModuleId) async {
    try {
      UserTestRecord tests = UserTestRecord();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      tests = await ElearningCourseProvider.getModuleTests(userToken ?? "", elearningModuleId);
      return tests;
    } on Exception {
      return UserTestRecord();
    }
  }

  static Future<ElearningTest> fetchSingleTestDetail(String elearningTestId) async {
    try {
      ElearningTest test = ElearningTest();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      test = await ElearningCourseProvider.getTestDetail(userToken ?? "", elearningTestId);
      return test;
    } on Exception {
      return ElearningTest();
    }
  }
}