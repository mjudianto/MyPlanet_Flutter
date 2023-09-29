import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';



// ignore: must_be_immutable
class PodtretContent extends StatelessWidget {
  final PodtretKontenController podtretKontenController = Get.find();
  late CustomVideoPlayerController customVideoPlayerController;

  PodtretContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Call initializeVideoPlayer only once when the widget is first built
    // if (!podtretKontenController.isVideoInitialized.value) {
     
    // }
    podtretKontenController.initializeVideoPlayer();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  // Video player widget
                  Positioned.fill(
                    child: Obx(() {
                      final isVideoInitialized = podtretKontenController.isVideoInitialized.value;

                      if (isVideoInitialized) {
                        final videoPlayerController = podtretKontenController.videoPlayerController;

                        customVideoPlayerController = CustomVideoPlayerController(
                          context: context,
                          videoPlayerController: videoPlayerController,
                        );
                      }

                      return isVideoInitialized
                          ? CustomVideoPlayer(
                              customVideoPlayerController: customVideoPlayerController,
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                            );
                    }),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.07,
                    left: 20,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconButton(
                          iconSize: 16,
                          color: blackColor,
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: !podtretKontenController.isVideoInitialized.value,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
