import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/profile/userLessonRecord/training_history_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';

class TrainingHistory extends StatelessWidget {
  TrainingHistory({Key? key}) : super(key: key);

  final TrainingHistoryPageController trainingHistoryPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Container(
        margin: const EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
        child: FutureBuilder(
          future: trainingHistoryPageController.fetchUserLessonRecord(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
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
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset(
                    'assets/error planet.png', // Replace this with the path to your logo image
                    height: 600, // Set the height of the logo image
                  ),
                ),
              );
            } else {
              // print(snapshot.data);

              if (snapshot.data != null) {
                final userLessonRecord = snapshot.data!.data;

                return SizedBox(
                  height: Get.height * 0.73,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: userLessonRecord?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final lessonRecord = userLessonRecord?[index]; // Replace with how you access your data

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                lessonRecord!.lessonName.toString(), // Replace with how you access the title
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                lessonRecord.attempt.toString(), // Replace with how you access the count
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                lessonRecord.courseName.toString(), // Replace with how you access the subtitle
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                ),
                              ),
                              Text(
                                lessonRecord.date.toString(), // Replace with how you access the date
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(
                            height: 2,
                            color: blackColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const Text('No data available.');
              }
            }
          },
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageAppBar(
                type: 'text',
                title: 'Training History',
              ),
              content()
            ],
          ),
        ),
      ),
    );
  }
}
