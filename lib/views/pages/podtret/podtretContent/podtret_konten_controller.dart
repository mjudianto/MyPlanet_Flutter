import 'package:get/get.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:myplanet/helpers/global_variable.dart';

class PodtretKontenController extends GetxController {
  late VideoPlayerController videoPlayerController;
  dynamic podtret;

  RxBool isVideoInitialized = false.obs;

  Future<void> initializeVideoPlayer() async {
    if (isVideoInitialized.value) {
      await videoPlayerController.dispose();
      isVideoInitialized.value = false;
    }

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse('${GlobalVariable.myplanetUrl}/${podtret.video}'));

    await videoPlayerController.initialize();

    isVideoInitialized.value = true;

    update(); // This triggers a rebuild of the widget using this controller.
  }


  @override
  void onClose() {
    videoPlayerController.dispose();
    isVideoInitialized.value = false;
    super.onClose();
  }
}
