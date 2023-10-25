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
  RxInt totalComment = 0.obs;
  bool podtretRecorded = false;

  Future<void> initializeVideoPlayer() async {
    if (isVideoInitialized.value) {
      await videoPlayerController.dispose();
      isVideoInitialized.value = false;
    }

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse('${GlobalVariable.myplanetUrl}/${podtret.video}'));

    await videoPlayerController.initialize();

    podtretRecorded = false;
    videoPlayerController.addListener(onVideoPositionChanged);

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
  }

  void submitPodtretCommentReply(String podtretCommentId, String comment) async {
    String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');

    await PodtretsProvider.submitPodtretCommentReply(userToken ?? "", podtretCommentId, comment);
  }

  timeCommentUploaded(String date) {
    DateTime uploadDate = DateTime.parse(date);
    DateTime now = DateTime.now();

    // Calculate the difference
    Duration difference = now.difference(uploadDate);

    int years = (difference.inDays / 365).floor();
    int months = (difference.inDays % 365) ~/ 30;
    int days = (difference.inDays % 365) % 30;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    if (years > 1) {
      return '$years years ago';
    } else if (months > 1) {
      return '$months months ago';
    } else if (days > 0) {
      return '$days days ago';
    } else if (hours > 0) {
      return '$hours hours ago';
    } else {
      return '$minutes minutes ago';
    }

  }

  Future<PodtretComment> fetchPodtretComments(String podtretId) async {
    try {
      PodtretComment comments = PodtretComment();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      comments = await PodtretsProvider.getPodtretComments(userToken ?? "", podtretId);

      totalComment.value = comments.podtretComment?.length ?? 0;

      return comments;
    } on Exception catch(e) { 
      throw Exception('error: $e');
    }
  }

  void onVideoPositionChanged() {
    final currentPosition = videoPlayerController.value.position.inSeconds;
    updateUserRecord(currentPosition);
  }

  void updateUserRecord(int positionInSeconds) async {
    const targetDuration = Duration(seconds: 5);
    if (videoPlayerController.value.position >= targetDuration) {
      if (!podtretRecorded) {
        podtretRecorded = true;

        String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
        await PodtretsProvider.setUserPodtretRecord(userToken ?? "", podtret.podtretId.toString());
      }
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    isVideoInitialized.value = false;
    super.onClose();
  }
}
