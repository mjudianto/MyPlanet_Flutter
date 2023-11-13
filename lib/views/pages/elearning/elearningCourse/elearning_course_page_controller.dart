import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/controllers/elearnings/user_record_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/providers/elearnings/elearning_provider.dart';

class ElearningCoursePageController extends GetxController {
  String elearningCourseId = '';

  VideoPlayerController? videoPlayerController;
  RxBool isVideoInitialized = false.obs;
  String currentVideo = '';
  bool lessonRecorded = false;
  String curretLessonId = '';
  TextEditingController textAlasanController = TextEditingController();

  Future<void> initializeVideoPlayer(elearningVideo, elearningLessonId) async {
    if (currentVideo != elearningVideo) {
      await disposeVideoPlayer();
      currentVideo = elearningVideo;
      curretLessonId = elearningLessonId;

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse('${GlobalVariable.myplanetUrl}/$elearningVideo'));

      await videoPlayerController!.initialize();

      lessonRecorded = false;
      videoPlayerController?.addListener(_onVideoPositionChanged);

      isVideoInitialized.value = true;

      update();
    }
  }

  disposeVideoPlayer() async {
    isVideoInitialized.value = false;

    if (videoPlayerController != null) {
      await videoPlayerController!.dispose();
    }
  }

  setElearningCourseId(courseId) async {
    elearningCourseId = courseId;
    curretLessonId = '';
    currentVideo = '';
    await disposeVideoPlayer();
  }

  void _onVideoPositionChanged() {
    final currentPosition = videoPlayerController?.value.position.inSeconds;
    // updateUserRecord(currentPosition!);
    // lessonRecorded = true;
    _updateUserRecord(currentPosition ?? 0);
  }

  void _updateUserRecord(int positionInSeconds) async {
    const targetDuration = 5;
    if (positionInSeconds >= targetDuration) {
      if (!lessonRecorded) {
        lessonRecorded = true;
        await UserRecordController.setUserLessonRecord(curretLessonId);
      }
    }
  }

  Future<ElearningCourseDetail> fetchCourseDetail() async {
    try {
      ElearningCourseDetail courseDetail = ElearningCourseDetail();

      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      courseDetail = await ElearningProvider.getElearningCourseDetail(userToken ?? "", elearningCourseId);
      return courseDetail;
    } on Exception catch (e) {
      throw Exception('error: $e');
    }
  }
}
