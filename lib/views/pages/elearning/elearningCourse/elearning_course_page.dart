import 'dart:async';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/controllers/elearnings/user_record_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/models/elearnings/elearning_module_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_post_test_access_request_model.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/elearning/pdf_page/pdf_page_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ElearningCoursePage extends StatefulWidget {
  const ElearningCoursePage({super.key});

  @override
  State<ElearningCoursePage> createState() => _ElearningCoursePageState();
}

class _ElearningCoursePageState extends State<ElearningCoursePage> {
  Future<ElearningCourseDetail>? _singleCourseFuture;
  Future<ElearningModule>? _courseModulesFuture;
  late VideoPlayerController _videoPlayerController;
  String lessonVideoUrl = "";
  Map<String, bool> moduleExpansionStates = {};
  Map<String, Future<List<dynamic>>> moduleDataFutures = {}; // Store lessons and tests data
  late CustomVideoPlayerController _customVideoPlayerController;
  bool videoInitialized = false;
  String currentLessonId = '';
  bool lessonRecorded = false;
  Future<UserPostTestAccessRequest>? _userPostTestAccessRequestFuture;

  ElearningCoursePageController elearningCoursePageController = Get.find();

  void updateVideoPlayer(String newVideoUrl, String elearningLessonId) {
    setState(() {
      videoInitialized = true;
      currentLessonId = elearningLessonId;
      lessonRecorded = false;

      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(newVideoUrl))..initialize().then((value) => setState(() {}));

      _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: _videoPlayerController,
      );
      _videoPlayerController.addListener(_onVideoPositionChanged);
    });
  }

  void _onVideoPositionChanged() {
    final currentPosition = _videoPlayerController.value.position.inSeconds;
    _updateUserRecord(currentPosition);
  }

  void _updateUserRecord(int positionInSeconds) async {
    const targetDuration = Duration(seconds: 5);
    if (_videoPlayerController.value.position >= targetDuration) {
      if (!lessonRecorded) {
        lessonRecorded = true;
        await UserRecordController.setUserLessonRecord(currentLessonId);
      }
    }
  }

  void disposeVideo() {
    _videoPlayerController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _singleCourseFuture = elearningCoursePageController.fetchSingleCourseDetail();
    _courseModulesFuture = elearningCoursePageController.fetchCourseModules();

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(lessonVideoUrl))..initialize().then((value) => setState(() {}));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
    );

    _courseModulesFuture?.then((modules) {
      for (var module in modules.data!) {
        moduleExpansionStates[module.elearningModuleId.toString()] = false;

        final moduleLessonsFuture = elearningCoursePageController.fetchModuleLessons(module.elearningModuleId.toString());
        final moduleTestsFuture = elearningCoursePageController.fetchModuleTests(module.elearningModuleId.toString());

        moduleDataFutures[module.elearningModuleId.toString()] = Future.wait([moduleLessonsFuture, moduleTestsFuture]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(color: backgroundColor),
          child: Column(
            children: [
              SizedBox(
                height: 350,
                width: Get.width,
                child: Stack(
                  children: [
                    // Video player widget
                    Positioned.fill(
                        child: _videoPlayerController.value.isInitialized
                            ? CustomVideoPlayer(
                                customVideoPlayerController: _customVideoPlayerController,
                              )
                            : Container(
                                decoration: const BoxDecoration(color: blackColor),
                              )),
                    Positioned(
                      top: Get.height * 0.07,
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
                                  GlobalVariable.currentUrl = '/elearning';
                                  disposeVideo();

                                  Get.offAllNamed(RouteName.dashboardPage);
                                })),
                      ),
                    ),
                    Visibility(
                      visible: videoInitialized ? (_videoPlayerController.value.isInitialized ? false : true) : false,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: _singleCourseFuture,
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
                        var course = snapshot.data;
                        // print('course');

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                course!.data![0].judul.toString(),
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
                                  // Visibility(visible: course.data?[0].averageRating.toString() == null ? false : true , child: const Icon(Icons.star, color: Color(0xffFFCE31), size: 16,)),
                                  // Text(
                                  //   course.data?[0].averageRating.toString() == 'null' ? "" : course.data![0].averageRating.toString(),
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     color: blackColor,
                                  //     fontWeight: medium,
                                  //     fontFamily: 'Poppins', // Set the font family to Poppins
                                  //   ),
                                  // ),
                                  // Text(
                                  //   course.data![0].responseCount.toString() == 'null' ? "" : ' (${course.data![0].responseCount.toString()}) • ',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     color: blackColor,
                                  //     fontWeight: medium,
                                  //     fontFamily: 'Poppins', // Set the font family to Poppins
                                  //   ),
                                  // ),
                                  Text(
                                    '${course.data![0].totalLessonsAndTests.toString()} lessons',
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
                                      course.data![0].createdBy ?? "Learning & People Development",
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
                          ],
                        );
                      } else {
                        // Handle the case when there is no data
                        return const Text('No data available.');
                      }
                    }
                  }),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20.0),
                  child: FutureBuilder<ElearningModule>(
                    future: _courseModulesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return DotLottieLoader.fromAsset("assets/loading.lottie", frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                          if (dotlottie != null) {
                            return Lottie.memory(dotlottie.animations.values.single, width: 250, height: 250, repeat: true);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        });
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('No modules available.');
                      } else {
                        final modules = snapshot.data!.data;
                        if (true) {
                          return SingleChildScrollView(
                            child: Column(
                                children: modules!.map((module) {
                              final moduleDataFuture = moduleDataFutures[module.elearningModuleId.toString()];
                              bool lastModule = false;

                              if (modules.last.elearningModuleId == module.elearningModuleId) {
                                lastModule = true;
                              }

                              return Padding(
                                padding: EdgeInsets.only(bottom: lastModule ? 32 : 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: whiteColor, borderRadius: BorderRadius.circular(15), border: Border.all(color: blackColor, width: 0.2)),
                                  child: Column(
                                    children: [
                                      ExpansionTile(
                                        initiallyExpanded: true,
                                        title: Text(
                                          module.judul!,
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
                                          child: Icon(
                                            moduleExpansionStates[module.elearningModuleId.toString()] ?? false
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 24,
                                            color: blackColor,
                                          ),
                                        ),
                                        onExpansionChanged: (expanded) {
                                          setState(() {
                                            moduleExpansionStates[module.elearningModuleId.toString()] = expanded;
                                          });
                                        },
                                        children: [
                                          moduleFuture(moduleDataFuture),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<dynamic>> moduleFuture(Future<List<dynamic>>? moduleDataFuture) {
    return FutureBuilder(
        future: moduleDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 200,
              child: DotLottieLoader.fromAsset("assets/loading.lottie", frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single, width: 250, height: 250, repeat: true);
                } else {
                  return const CircularProgressIndicator();
                }
              }),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No lesson available.');
          } else {
            final List<dynamic> results = snapshot.data as List<dynamic>;
            final lessons = results[0].data;
            final tests = results[1].data;
            final lessonsLength = lessons!.length + (tests == null ? 0 : tests.length);

            // final double sizeBoxLength = 50.0 * lessonsLength + (tests == null ? 25 : 50);

            return Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: lessonsLength,
                itemBuilder: (context, index) {
                  final lesson = index < lessons.length ? lessons[index] : tests[index - lessons.length];
                  final bool isLesson = index < lessons.length;

                  return GestureDetector(
                    onTap: isLesson
                        ? () {
                            if (lesson.konten.toString().toLowerCase().endsWith('.pdf')) {
                              PdfPageController pdfPageController = Get.find();
                              pdfPageController.pdfPath = RxString(lesson.konten);

                              Get.toNamed(RouteName.elearningPdfPage);
                            } else {
                              updateVideoPlayer('${GlobalVariable.myplanetUrl}/${lesson.konten}', lesson.elearningLessonId.toString());
                            }
                          }
                        : () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                _userPostTestAccessRequestFuture =
                                    UserRecordController.checkExistingUserPostTestAccessRequest(lesson.elearningTestId.toString());

                                return StartPostTestConfirmationModal(
                                  lesson: lesson,
                                  future: _userPostTestAccessRequestFuture,
                                );
                              },
                              isScrollControlled: true,
                            );
                          },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: isLesson ? 2.5 : 7),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        isLesson
                                            ? 'assets/lesson_placeholder.png'
                                            : 'assets/test_placeholder.png', // Replace this with the path to your logo image
                                        width: 75, // Set the width of the logo image
                                        height: isLesson ? 50 : 65, // Set the height of the logo image
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          lesson.judul ?? "",
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
                                  SizedBox(height: isLesson ? 5 : 2),
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
                                  Visibility(visible: !isLesson, child: const SizedBox(height: 3)),
                                  Visibility(
                                      visible: !isLesson,
                                      child: SizedBox(
                                        width: 180,
                                        child: Row(
                                          children: [
                                            TestDetail(
                                              icon: 'assets/icons/test_passed.png',
                                              text: !isLesson ? (lesson.score == null ? '0' : lesson.score.toString()) : "",
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            TestDetail(
                                              icon: 'assets/icons/test_attempt.png',
                                              text: !isLesson ? (lesson.attempt == null ? '0' : lesson.attempt.toString()) : "",
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            TestDetail(
                                              icon: 'assets/icons/test_status.png',
                                              text: !isLesson
                                                  ? (lesson.attempt == null ? '-' : ((lesson.score ?? 0) > lesson.passingScore ? "Lulus" : "Gagal"))
                                                  : "",
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
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

// ignore: must_be_immutable
class StartPostTestConfirmationModal extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final lesson;
  Future<UserPostTestAccessRequest>? future;

  StartPostTestConfirmationModal({super.key, required this.lesson, this.future});

  @override
  State<StartPostTestConfirmationModal> createState() => _StartPostTestConfirmationModalState();
}

class _StartPostTestConfirmationModalState extends State<StartPostTestConfirmationModal> {
  TextEditingController textAlasanController = TextEditingController();

  Widget bottom(BuildContext context, RxBool maxtAttemptReached) {
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapshot) {
          // print('awfgaegaegaeg');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: 200,
                child: Center(
                  child: DotLottieLoader.fromAsset("assets/loading.lottie", frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                    if (dotlottie != null) {
                      return Lottie.memory(dotlottie.animations.values.single, width: 250, height: 250, repeat: true);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
                ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No lesson available.');
          } else {
            final userPostTestAccessRequest = snapshot.data;

            RxBool requestSent = (userPostTestAccessRequest?.data != null && userPostTestAccessRequest!.data?.adminReply == 0).obs;
            RxBool underPunishment = false.obs;
            int secondsDifference = 0;

            if (userPostTestAccessRequest?.data?.punishment != null &&
                !(DateTime.now().isAfter(DateTime.parse(userPostTestAccessRequest?.data?.punishment)))) {
              DateTime endTime = DateTime.parse(userPostTestAccessRequest!.data?.punishment); // Start time
              DateTime currentDateTime = DateTime.now();

              // Calculate the duration between the two times
              Duration timeDifference = endTime.difference(currentDateTime);

              // Calculate the time difference in seconds
              secondsDifference = timeDifference.inSeconds;
              underPunishment.value = true;
            }
            final MediaQueryData mediaQueryData = MediaQuery.of(context);

            return Padding(
              padding: mediaQueryData.viewInsets,
              child: Container(
                height: maxtAttemptReached.value ? (requestSent.value ? 250 : 418) : 338,
                // height: 100,
                padding: const EdgeInsets.all(16),
                // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        )),
                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.lesson.judul,
                            style: TextStyle(fontSize: 18, color: blackColor, fontWeight: semiBold, fontFamily: 'Poppins'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Obx(() {
                            return Text(
                              maxtAttemptReached.value
                                  ? (requestSent.value
                                      ? 'anda sudah mengirim request. mohon menunggu balasan dari admin'
                                      : 'Post Test anda sudah melebihi batas maksimal percobaan. Mohon untuk mengisi form alasan di bawah ini guna memohon akses Post Test terbaru.')
                                  : (underPunishment.value
                                      ? 'Anda sedang dalam masa pembelajaran. Silahkan menunggu beberapa saat untuk memulai test kembali.'
                                      : 'Silahkan mengerjakan quiz dengan tenang tanpa gangguan'),
                              style: TextStyle(fontSize: 12, color: blackColor, fontWeight: regular, fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                            );
                          }),
                          const SizedBox(height: 30),
                          Obx(() => Visibility(
                                visible: !maxtAttemptReached.value && !underPunishment.value,
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
                                          widget.lesson.passingScore.toString(),
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
                                          '${(widget.lesson.timeLimit ~/ 60000).toString()} Minutes',
                                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: whiteColor, fontWeight: bold),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              )),
                          Obx(() => Visibility(
                                visible: maxtAttemptReached.value && !requestSent.value && !underPunishment.value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Alasan',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: medium),
                                    ),
                                    TextField(
                                      controller: textAlasanController,
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
                              )),
                          Obx(
                            () => Visibility(
                                visible: underPunishment.value,
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
                                            underPunishment.value = false;
                                            underPunishment.refresh();
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
                                          Text(userPostTestAccessRequest?.data != null && userPostTestAccessRequest?.data?.adminReplyMessage != null
                                              ? userPostTestAccessRequest?.data!.adminReplyMessage
                                              : "tidak ada catatan"),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Obx(() => SizedBox(
                                width: Get.width * 0.8,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (maxtAttemptReached.value && !requestSent.value && !underPunishment.value) {
                                      try {
                                        await UserRecordController.sendUserPostTestAccessRequest(
                                            widget.lesson.elearningTestId.toString(), textAlasanController.text);
                                        requestSent.value = true;
                                      } catch (err) {
                                        // print(err);
                                      }
                                    } else if (maxtAttemptReached.value || underPunishment.value) {
                                      Get.back();
                                    } else {
                                      ElearningTestPageController elearningTestPageController = Get.find();
                                      elearningTestPageController.setElearningTestId(widget.lesson.elearningTestId);

                                      elearningTestPageController.passingScore = widget.lesson.passingScore;

                                      Get.toNamed(RouteName.elearningTestPage);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: maxtAttemptReached.value && !requestSent.value && !underPunishment.value
                                        ? primaryColor
                                        : (maxtAttemptReached.value ? secondaryColor : (underPunishment.value ? secondaryColor : primaryColor)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Text(
                                      maxtAttemptReached.value && !requestSent.value && !underPunishment.value
                                          ? 'Send Request'
                                          : (maxtAttemptReached.value ? 'back' : (underPunishment.value ? 'back' : 'start')),
                                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: semiBold),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    RxBool maxtAttemptReached = (widget.lesson.maxAttempt != null && widget.lesson.maxAttempt <= widget.lesson.attempt).obs;

    return bottom(context, maxtAttemptReached);
  }
}
