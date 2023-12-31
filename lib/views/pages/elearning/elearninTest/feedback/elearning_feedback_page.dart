import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/feedback/elearning_feedback_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';

class ElearningFeedbackPage extends StatelessWidget {
  ElearningFeedbackPage({super.key});

  final ElearningFeedbackPageController elearningFeedbackPageController = Get.find();
  final ElearningTestPageController elearningTestPageController = Get.find();
  final TextEditingController feedbackTextController = TextEditingController();

  final List<Map> feedbacks = [];

  @override
  Widget build(BuildContext context) {
    final bool lulus = elearningTestPageController.status == 'Lulus';
    // if (!elearningFeedbackPageController.feedbackSent.value && lulus) {
    //   elearningFeedbackPageController.fetchFeedbackQuestion();
    // }

    return Obx(() {
      if (!elearningFeedbackPageController.feedbackSent.value && lulus) {
        return Scaffold(
          appBar: PageAppBar(
            type: 'text',
            title: 'Feedback',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        elearningTestPageController.elearningTest.data?[0].judul ?? "",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: semiBold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: Get.height * 0.55,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Set physics to make it unscrollable
                      itemCount: elearningFeedbackPageController.feedbackQuestion.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (feedbacks.length <= index) {
                          feedbacks.add({
                            'feedbackQuestionId': (elearningFeedbackPageController.feedbackQuestion.data?[index].feedbackQuestionId).toString(),
                            "feedback": '0'
                          });
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                elearningFeedbackPageController.feedbackQuestion.data![index].question.toString(),
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: blackColor, fontWeight: medium),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FeedbackAnswer(
                                feedbacks: feedbacks[index],
                                questionType: elearningFeedbackPageController.feedbackQuestion.data![index].questionType!,
                                controller: feedbackTextController),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        feedbacks[4]['feedback'] = feedbackTextController.text.toString();

                        elearningFeedbackPageController.sendUserFeedback(feedbacks);

                        elearningFeedbackPageController.feedbackSent.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: semiBold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
        );
      } else {
        return Scaffold(
          appBar: PageAppBar(
            type: 'text',
            title: 'Result',
          ),
          body: Container(
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.5,
                    decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          DotLottieLoader.fromAsset(lulus ? "assets/icons/greenChecklist.lottie" : "assets/icons/redX.lottie",
                              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                            if (dotlottie != null) {
                              return Lottie.memory(dotlottie.animations.values.single, width: 120, height: 120, repeat: false);
                            } else {
                              return Container();
                            }
                          }),
                          Text(
                            '${!lulus ? 'Failed' : 'Congrats'}!',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: bold, color: blackColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${!lulus ? 'Post test gagal, mohon coba lagi' : 'Post test completed successfully'}!',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: bold, color: blackColor),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'YOUR SCORE',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: medium, color: secondaryColor),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            elearningTestPageController.score.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: semiBold,
                              color: !lulus ? dangerColor : successColor,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          RichText(
                            text: TextSpan(
                                text: lulus ? 'Terima Kasih telah menyelesaikan ' : 'Mohon maaf anda gagal dalam menyelesaikan ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: medium,
                                  color: blackColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: elearningTestPageController.elearningTest.data![0].judul,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: bold,
                                      color: blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: lulus ? ' dengan baik.' : ', mohon coba lagi',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: medium,
                                      color: blackColor,
                                    ), // Default style
                                  ),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Get.offAllNamed(RouteName.elearningCoursePage);
                      Get.offNamed(RouteName.elearningCoursePage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Back',
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: semiBold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }
}

class FeedbackAnswer extends StatelessWidget {
  const FeedbackAnswer({
    super.key,
    required this.feedbacks,
    required this.questionType,
    this.controller,
  });

  final Map<dynamic, dynamic> feedbacks;
  final int questionType;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    if (questionType == 1) {
      return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          child: RatingBar(
            initialRating: double.tryParse(feedbacks['feedback']) ?? 0.0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 4,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            ratingWidget: RatingWidget(
              full: Image.asset(
                'assets/icons/star_colored.png',
              ),
              half: Image.asset(
                'assets/icons/star_colored.png',
              ),
              empty: Image.asset(
                'assets/icons/star.png',
              ),
            ),
            onRatingUpdate: (rating) {
              feedbacks['feedback'] = rating.toStringAsFixed(0);
              // print(feedbacks);
            },
            itemSize: 24,
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          child: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove the underline
              filled: true, // Fill the container with the background color
              fillColor: pastelSecondaryColor, // Set your background color here
            ),
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: blackColor, fontWeight: medium),
          ),
        ),
      );
    }
  }
}
