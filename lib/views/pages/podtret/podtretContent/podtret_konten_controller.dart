import 'package:get/get.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:intl/intl.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/podtrets/podtret_comment_models.dart';
import 'package:myplanet/providers/podtrets/podtret_provider.dart';

class PodtretKontenController extends GetxController {
  late VideoPlayerController videoPlayerController;
  dynamic podtret;

  RxBool isVideoInitialized = false.obs;
  late Rx<Future<PodtretComment>> podtretComments;

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

  publishDate() {
    DateTime dateTime = DateTime.parse(podtret.publishDate.toString());
    String publishDate = DateFormat('dd MMMM yyyy').format(dateTime);

    return publishDate;
  }

  void likePodtret(String podtretId) async {
    String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');

    await PodtretsProvider.podtretLike(userToken ?? "", podtretId);

    // print('success');
  }

  void submitPodtretComment(String podtretId, String comment) async {
    String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');

    await PodtretsProvider.submitPodtretComment(userToken ?? "", podtretId, comment);

    print('success');
  }

  timeCommentUploaded(String date) {
    DateTime uploadDate = DateTime.parse(date);
    DateTime now = DateTime.now();

    // Calculate the difference
    Duration difference = now.difference(uploadDate);

    int years = (difference.inDays / 365).floor();
    int months = (difference.inDays % 365) ~/ 30;
    int days = (difference.inDays % 365) % 30;

    if (years > 1) {
      return '$years years ago';
    } else if (months > 1) {
      return '$months months ago';
    } else {
      return '$days days ago';
    }
  }

  Future<PodtretComment> fetchPodtretComments(String podtretId) async {
    try {
      PodtretComment comments = PodtretComment();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      comments = await PodtretsProvider.getPodtretComments(userToken ?? "", podtretId);

      return comments;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }


  @override
  void onClose() {
    videoPlayerController.dispose();
    isVideoInitialized.value = false;
    super.onClose();
  }
}
