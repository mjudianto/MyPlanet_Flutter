import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/controllers/elearnings/elearning_course_controller.dart';
import 'package:myplanet/controllers/elearnings/user_record_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/elearnings/elearning_course_detail_model.dart';
import 'package:myplanet/models/elearnings/elearning_module_model.dart';
import 'package:myplanet/models/elearnings/userRecords/user_post_test_access_request_model.dart';
import 'package:myplanet/theme.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ElearningCoursePage extends StatefulWidget {
  const ElearningCoursePage({super.key, required this.elearningCourseId});

  final String elearningCourseId;

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

  void updateVideoPlayer(String newVideoUrl, String elearningLessonId) {
    setState(() {
      videoInitialized = true;
      currentLessonId = elearningLessonId;
      lessonRecorded = false;

      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(newVideoUrl))
      ..initialize().then((value) => setState(() {}));

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _singleCourseFuture = ElearningCourseController.fetchSingleCourseDetail(widget.elearningCourseId);
    _courseModulesFuture = ElearningCourseController.fetchCourseModules(widget.elearningCourseId);

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(lessonVideoUrl))
      ..initialize().then((value) => setState(() {}));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
    );

    _courseModulesFuture?.then((modules) {
      for (var module in modules.data!) {
        moduleExpansionStates[module.elearningModuleId.toString()] = false;

        final moduleLessonsFuture = ElearningCourseController.fetchModuleLessons(module.elearningModuleId.toString());
        final moduleTestsFuture = ElearningCourseController.fetchModuleTests(module.elearningModuleId.toString());

        moduleDataFutures[module.elearningModuleId.toString()] = Future.wait([moduleLessonsFuture, moduleTestsFuture]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  // Video player widget
                  Positioned.fill(
                    child: _videoPlayerController.value.isInitialized
                    ? CustomVideoPlayer(
                      customVideoPlayerController: _customVideoPlayerController,
                    )
                    : Container(
                      decoration: const BoxDecoration(
                        color: blackColor
                      ),
                    )
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
                            GlobalVariable.currentUrl = '/elearning';
                            disposeVideo();
                            GoRouter.of(context).pop();
                          }
                        )
                      ),
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
                  return 
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle any errors that occurred during the Future execution
                  return
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
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

                    return
                    Column(
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
                              Visibility(visible: course.data?[0].averageRating.toString() == null ? false : true , child: const Icon(Icons.star, color: Color(0xffFFCE31), size: 16,)),
                              Text(
                                course.data?[0].averageRating.toString() == 'null' ? "" : course.data![0].averageRating.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: blackColor,
                                  fontWeight: medium,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                              ),
                              Text(
                                course.data![0].responseCount.toString() == 'null' ? "" : ' (${course.data![0].responseCount.toString()}) • ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: blackColor,
                                  fontWeight: medium,
                                  fontFamily: 'Poppins', // Set the font family to Poppins
                                ),
                              ),
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
                                width: MediaQuery.of(context).size.width * 0.8,
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
              }
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20.0),
                child: FutureBuilder<ElearningModule>(
                  future: _courseModulesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('No modules available.');
                    } else {
                      final modules = snapshot.data!.data;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: modules?.length ?? 0,
                        itemBuilder: (context, index) {
                          final module = modules![index];
                          final moduleDataFuture = moduleDataFutures[module.elearningModuleId.toString()];
                            
                          return Padding(
                            padding: EdgeInsets.only(bottom: index != modules.length - 1 ? 12 : 30), // Adjust the vertical padding as needed
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: blackColor),
                              ),
                              child: Column(
                                children: [
                                  ExpansionTile(
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
                                      FutureBuilder(
                                        future: moduleDataFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const SizedBox(
                                              height: 200,
                                              child: Center(child: CircularProgressIndicator())
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

                                            final double sizeBoxLength = lessonsLength * 50 > 200 ? 200 : 50.0 * lessonsLength + (tests == null ? 25 : 50);

                                            return SizedBox(
                                              height: sizeBoxLength,
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: lessonsLength,
                                                itemBuilder: (context, index) {
                                                  final lesson = index < lessons.length ? lessons[index] : tests[index-lessons.length];
                                                  final bool isLesson = index < lessons.length;

                                                  return GestureDetector(
                                                    onTap: isLesson ? () {
                                                      updateVideoPlayer('https://myplanet.enseval.com/${lesson.konten}', lesson.elearningLessonId.toString());
                                                    } 
                                                    : (){
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          _userPostTestAccessRequestFuture = UserRecordController.checkExistingUserPostTestAccessRequest(lesson.elearningTestId.toString());
                                                          return StartPostTestConfirmationModal(
                                                            lesson: lesson,
                                                            future: _userPostTestAccessRequestFuture,
                                                          ); // Use the widget you created
                                                        },
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 15.0, right: 15, bottom: index == lessonsLength - 1 ? 15 : 3, top: isLesson ? 0 : 5),
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
                                                                      isLesson ? 'assets/lesson_placeholder.png' : 'assets/test_placeholder.png', // Replace this with the path to your logo image
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
                                                                Visibility(
                                                                  visible: !isLesson,
                                                                  child: const SizedBox(height: 3)
                                                                ),
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
                                                                        const SizedBox(width: 8,),
                                                                        TestDetail(
                                                                        icon: 'assets/icons/test_attempt.png',
                                                                        text:  !isLesson ? (lesson.attempt == null ? '0' : lesson.attempt.toString()) : "",
                                                                        ),
                                                                        const SizedBox(width: 8,),
                                                                        TestDetail(
                                                                        icon: 'assets/icons/test_status.png',
                                                                        text:  !isLesson ? ((lesson.score ?? 0) > lesson.passingScore ? "Lulus" : "Gagal") : "",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                )
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
                                                                    )
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                                
                                            );
                                          }
                                        }
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
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
    return Row (
      children: [
        Image.asset(
          icon,
          height: 12,
          width: 12,
        ),
        const SizedBox(width: 5,),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: semiBold,
          ),
        ),
      ]
    );
      
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
  @override
  Widget build(BuildContext context) {
    bool maxtAttemptReached = widget.lesson.maxAttempt != null && widget.lesson.maxAttempt <= widget.lesson.attempt;
    TextEditingController textAlasanController = TextEditingController();

    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot)  {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No lesson available.');
        } else {
          final userPostTestAccessRequest = snapshot.data;

          final bool requestSent = userPostTestAccessRequest?.data != null && userPostTestAccessRequest!.data?.adminReply == 0;
          bool underPunishment = false;
          int secondsDifference = 0;
          if (userPostTestAccessRequest?.data?.punishment != null && !(DateTime.now().isAfter(DateTime.parse(userPostTestAccessRequest?.data?.punishment)))) {
            DateTime endTime = DateTime.parse(userPostTestAccessRequest!.data?.punishment); // Start time
            DateTime currentDateTime = DateTime.now();

            // Calculate the duration between the two times
            Duration timeDifference = endTime.difference(currentDateTime);

            // Calculate the time difference in seconds
            secondsDifference = timeDifference.inSeconds;
            underPunishment = true;
          }
          
          return Container(
            height: maxtAttemptReached ? (requestSent ? 300 : 468) : 388,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                  )
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.lesson.judul,
                        style: TextStyle(
                          fontSize: 18,
                          color: blackColor,
                          fontWeight: semiBold,
                          fontFamily: 'Poppins'
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        maxtAttemptReached
                        ? ( requestSent
                          ? 'anda sudah mengirim request. mohon menunggu balasan dari admin'
                          : 'Post Test anda sudah melebihi batas maksimal percobaan. Mohon untuk mengisi form alasan di bawah ini guna memohon akses Post Test terbaru.'
                        )
                        : ( underPunishment
                          ? 'Anda sedang dalam masa pembelajaran. Silahkan menunggu beberapa saat untuk memulai test kembali.'
                          : 'Silahkan mengerjakan quiz dengan tenang tanpa gangguan'
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          fontWeight: regular,
                          fontFamily: 'Poppins'
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Visibility(
                        visible: !maxtAttemptReached && !underPunishment,
                        child: Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Passing Score',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: whiteColor,
                                      fontWeight: medium
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    widget.lesson.passingScore.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: whiteColor,
                                      fontWeight: bold
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                                child: Container(
                                  color: whiteColor, // Set the color of the separator
                                  width: 2,       // Set the thickness of the separator
                                  height: 50,          // Set the width of the separator
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: whiteColor,
                                      fontWeight: medium
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    '${(widget.lesson.timeLimit~/60000).toString()} Minutes',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: whiteColor,
                                      fontWeight: bold
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ),
                        ),
                      ),
                      Visibility(
                        visible: maxtAttemptReached && !requestSent && !underPunishment,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alasan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: medium
                              ),
                            ),
                            TextField(
                              controller: textAlasanController,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                border: InputBorder.none, // Remove the underline
                                filled: true, // Fill the container with the background color
                                fillColor: pastelSecondaryColor, // Set your background color here
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: underPunishment,
                        child: Column (
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
                                    String formattedTime = '${hours}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    
                                    return Text(
                                      formattedTime,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: semiBold
                                      ),
                                    );
                                  },
                                  interval: const Duration(milliseconds: 1000),
                                  onFinished: () async {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Catatan :'),
                                  const SizedBox(height: 10,),
                                  Text(
                                    userPostTestAccessRequest?.data != null && userPostTestAccessRequest?.data?.adminReplyMessage != null ? userPostTestAccessRequest?.data!.adminReplyMessage : "tidak ada catatan"
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        )
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (maxtAttemptReached && !requestSent && !underPunishment) {
                              try {
                                await UserRecordController.sendUserPostTestAccessRequest(widget.lesson.elearningTestId.toString(), textAlasanController.text);
                                setState(() {
                                  widget.future = UserRecordController.checkExistingUserPostTestAccessRequest(widget.lesson.elearningTestId.toString());
                                });
                              } catch (err) {
                                // print(err);
                              }
                            } else if (maxtAttemptReached || underPunishment) {
                              Navigator.of(context).pop();
                            }
                            else {
                              context.push('/elearning/test/${widget.lesson.elearningTestId}');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maxtAttemptReached && !requestSent && !underPunishment ? primaryColor : (maxtAttemptReached ? secondaryColor : (underPunishment ? secondaryColor : primaryColor)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              maxtAttemptReached && !requestSent && !underPunishment ? 'Send Request' : (maxtAttemptReached ? 'back' : (underPunishment ? 'back' : 'start')),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: semiBold
                              ),  
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }
}



