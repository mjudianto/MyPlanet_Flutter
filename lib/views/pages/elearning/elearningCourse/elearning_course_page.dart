import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/controllers/elearnings/user_record_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

// ignore: must_be_immutable
class ElearningCoursePage extends StatelessWidget {
  ElearningCoursePage({super.key});

  final ElearningCoursePageController elearningCoursePageController = Get.find();
  late CustomVideoPlayerController customVideoPlayerController;
  List<RxBool> moduleExpansionState = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // Video player widget
                Positioned.fill(
                  child: Obx(() {
                    if (elearningCoursePageController.isVideoInitialized.value) {
                      final videoPlayerController = elearningCoursePageController.videoPlayerController;

                      customVideoPlayerController = CustomVideoPlayerController(
                        context: context,
                        videoPlayerController: videoPlayerController!,
                      );
                    }

                    return elearningCoursePageController.isVideoInitialized.value
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
                    visible: !elearningCoursePageController.isVideoInitialized.value && elearningCoursePageController.currentVideo != '',
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }),
              ],
            ),
          ),
          FutureBuilder(
              future: elearningCoursePageController.fetchCourseDetail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while waiting for the future to complete
                  return SizedBox(
                    height: 100,
                    width: Get.width,
                    child: Center(
                      child: DotLottieLoader.fromAsset("assets/loading.lottie", frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                        if (dotlottie != null) {
                          return Lottie.memory(dotlottie.animations.values.single, width: 250, height: 250, repeat: true);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle any errors that occurred during the Future execution
                  return SizedBox(
                    height: 100,
                    width: Get.width,
                    child: const Center(
                      child: Text(
                        'Error: Error: Data Load Failed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  // If the Future completed successfully, display the data
                  if (snapshot.data != null) {
                    var course = snapshot.data!.data;

                    course?.modules?.forEach((module) {
                      moduleExpansionState.add(RxBool(true));
                    });

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            course!.judul.toString(),
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${course.totalLessonsAndTests.toString()} lessons',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: medium,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/course_createdBy_icon.png',
                                color: blackColor,
                                height: 13,
                              ),
                              const Text(' '),
                              SizedBox(
                                width: Get.width * 0.8,
                                child: Text(
                                  course.createdBy ?? "Learning & People Development",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: blackColor,
                                    fontWeight: medium,
                                    fontFamily: 'Poppins', // Set the font family to Poppins
                                  ),
                                  overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                                  maxLines: 1, // Limit the text to a single line
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20.0),
                          child: SizedBox(
                            height: Get.height * 0.4,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: course.modules!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final module = course.modules?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: blackColor, width: 0.2),
                                    ),
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          maintainState: true,
                                          initiallyExpanded: true,
                                          title: Text(
                                            module!.judul.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: blackColor,
                                              fontWeight: semiBold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          trailing: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Obx(
                                              () => Icon(
                                                moduleExpansionState[index].value == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                                size: 24,
                                                color: blackColor,
                                              ),
                                            ),
                                          ),
                                          onExpansionChanged: (expanded) {
                                            moduleExpansionState[index].value = expanded;
                                          },
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(maxHeight: double.infinity),
                                              child: Column(
                                                children: [
                                                  LessonBuilder(
                                                    module: module,
                                                  ),
                                                  TestBuilder(
                                                    module: module,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return const Text('no data');
                }
              })
          // print('course');
        ],
      ),
    );
  }
}

class TestDetail extends StatelessWidget {
  const TestDetail({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        icon,
        height: 12,
        width: 12,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: semiBold,
        ),
      ),
    ]);
  }
}

class LessonBuilder extends StatelessWidget {
  LessonBuilder({
    super.key,
    required this.module,
  });

  final Module module;
  final ElearningCoursePageController elearningCoursePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: module.lessons!.length,
        itemBuilder: (BuildContext context, int index) {
          final lesson = module.lessons?[index];
          return GestureDetector(
            onTap: () async =>
                await elearningCoursePageController.initializeVideoPlayer(lesson.konten.toString(), lesson.elearningLessonId.toString()),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5),
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/lesson_placeholder.png', // Replace this with the path to your logo image
                                  width: 75, // Set the width of the logo image
                                  height: 50, // Set the height of the logo image
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: Text(
                                lesson!.judul ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: semiBold,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                                overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                                maxLines: 1, // Limit the text to a single line
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: Text(
                                GlobalVariable.userData['user']['empnik'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: medium,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                                overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                                maxLines: 1, // Limit the text to a single line
                              ),
                            )
                          ],
                        ),
                      ]),
                      const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Icon(
                                    Icons.play_circle_fill_rounded,
                                    size: 24,
                                    color: primaryColor,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ]))),
          );
        });
  }
}

class TestBuilder extends StatelessWidget {
  TestBuilder({
    super.key,
    required this.module,
  });

  final Module module;
  final ElearningCoursePageController elearningCoursePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: module.tests!.length,
        itemBuilder: (BuildContext context, int index) {
          final test = module.tests?[index];
          bool maxtAttemptReached = test?.attempt == test?.maxAttempt;
          bool requestSent = maxtAttemptReached && (test?.adminReply == 0);
          bool underPunishment = false;
          int secondsDifference = 0;

          if (test?.punishment != null && !(DateTime.now().isAfter(DateTime.parse(test?.punishment)))) {
            DateTime endTime = DateTime.parse(test?.punishment); // Start time
            DateTime currentDateTime = DateTime.now();

            // Calculate the duration between the two times
            Duration timeDifference = endTime.difference(currentDateTime);

            // Calculate the time difference in seconds
            secondsDifference = timeDifference.inSeconds;
            underPunishment = true;
          }

          return GestureDetector(
            onTap: () async => {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  final MediaQueryData mediaQueryData = MediaQuery.of(context);
                  return Padding(
                    padding: mediaQueryData.viewInsets,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      height: maxtAttemptReached ? (requestSent ? 250 : 420) : (underPunishment ? 380 : 420),
                      child: Column(
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'POST TEST',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: medium,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the bottom sheet
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                test.judul.toString(),
                                style: TextStyle(fontSize: 18, color: blackColor, fontWeight: semiBold, fontFamily: 'Poppins'),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                maxtAttemptReached
                                    ? (requestSent
                                        ? 'anda sudah mengirim request. mohon menunggu balasan dari admin'
                                        : 'Post Test anda sudah melebihi batas maksimal percobaan. Mohon untuk mengisi form alasan di bawah ini guna memohon akses Post Test terbaru.')
                                    : (underPunishment
                                        ? 'Anda sedang dalam masa pembelajaran. Silahkan menunggu beberapa saat untuk memulai test kembali.'
                                        : 'Silahkan mengerjakan quiz dengan tenang tanpa gangguan'),
                                style: TextStyle(fontSize: 12, color: blackColor, fontWeight: regular, fontFamily: 'Poppins'),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ),
                          const SizedBox(height: 30),
                          Visibility(
                            visible: !maxtAttemptReached && !underPunishment,
                            child: Container(
                              height: 75,
                              width: Get.width * 0.8,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Passing Score',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: whiteColor, fontWeight: medium),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      test.passingScore.toString(),
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: whiteColor, fontWeight: bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Container(
                                    color: whiteColor, // Set the color of the separator
                                    width: 2, // Set the thickness of the separator
                                    height: 50, // Set the width of the separator
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Time',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: whiteColor, fontWeight: medium),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${(test.timeLimit! ~/ 60000).toString()} Minutes',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: whiteColor, fontWeight: bold),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                          Visibility(
                            visible: maxtAttemptReached && !requestSent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alasan',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: medium),
                                ),
                                TextField(
                                  controller: elearningCoursePageController.textAlasanController,
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none, // Remove the underline
                                    filled: true, // Fill the container with the background color
                                    fillColor: pastelSecondaryColor, // Set your background color here
                                  ),
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: blackColor, fontWeight: medium),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                              visible: underPunishment,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Akses akan terbuka pada : '),
                                      Countdown(
                                        seconds: secondsDifference,
                                        build: (BuildContext context, double time) {
                                          // Convert time from seconds to a Duration object
                                          Duration duration = Duration(seconds: time.toInt());

                                          // Extract hours, minutes, and seconds components from the Duration
                                          int hours = duration.inHours;
                                          int minutes = duration.inMinutes.remainder(60);
                                          int seconds = duration.inSeconds.remainder(60);

                                          // Format the components as HH:MM:SS
                                          String formattedTime =
                                              '${hours}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';

                                          return Text(
                                            formattedTime,
                                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: semiBold),
                                          );
                                        },
                                        interval: const Duration(milliseconds: 1000),
                                        onFinished: () async {
                                          underPunishment = false;
                                          Get.off(() => ElearningCoursePage(), transition: Transition.noTransition);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Catatan :'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(test.adminReplyMessage ?? "tidak ada catatan"),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: maxtAttemptReached ? (requestSent ? 0 : 30) : 30,
                          ),
                          SizedBox(
                            width: Get.width * 0.8,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (maxtAttemptReached) {
                                  if (!requestSent) {
                                    await UserRecordController.sendUserPostTestAccessRequest(
                                        test.elearningtestid.toString(), elearningCoursePageController.textAlasanController.text);
                                    elearningCoursePageController.textAlasanController.clear();
                                    Get.back();
                                    // Get.offAndToNamed(RouteName.elearningCoursePage);
                                    Get.off(() => ElearningCoursePage(), transition: Transition.noTransition);
                                  } else {
                                    Get.back();
                                    Get.off(() => ElearningCoursePage(), transition: Transition.noTransition);
                                  }
                                } else {
                                  if (underPunishment) {
                                    Get.back();
                                  } else {
                                    ElearningTestPageController elearningTestPageController = Get.find();
                                    elearningTestPageController.setElearningTestId(test.elearningtestid);

                                    elearningTestPageController.passingScore = test.passingScore!;

                                    Get.toNamed(RouteName.elearningTestPage);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: maxtAttemptReached ? primaryColor : (underPunishment ? secondaryColor : secondaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  maxtAttemptReached && !requestSent
                                      ? 'Send Request'
                                      : (maxtAttemptReached ? 'Back' : (underPunishment ? 'Back' : 'Start')),
                                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: semiBold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                isScrollControlled: true,
              )
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/test_placeholder.png', // Replace this with the path to your logo image
                                  width: 75, // Set the width of the logo image
                                  height: 65, // Set the height of the logo image
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: Text(
                                test!.judul ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: semiBold,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                                overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                                maxLines: 1, // Limit the text to a single line
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2.5),
                        Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: Text(
                                GlobalVariable.userData['user']['empnik'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: medium,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                                overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                                maxLines: 1, // Limit the text to a single line
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2.5),
                        SizedBox(
                          width: 180,
                          child: Row(
                            children: [
                              TestDetail(
                                icon: 'assets/icons/test_passed.png',
                                text: test.score == null ? '0' : test.score.toString(),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TestDetail(
                                icon: 'assets/icons/test_attempt.png',
                                text: test.attempt == null ? '0' : test.attempt.toString(),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TestDetail(
                                  icon: 'assets/icons/test_status.png',
                                  text: test.attempt == null ? '-' : ((test.score ?? 0) > test.passingScore!.toInt() ? "Lulus" : "Gagal")),
                            ],
                          ),
                        ),
                      ]),
                      const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Icon(
                                    Icons.play_circle_fill_rounded,
                                    size: 24,
                                    color: primaryColor,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ]))),
          );
        });
  }
}
