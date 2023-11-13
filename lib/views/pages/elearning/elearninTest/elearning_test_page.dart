import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/feedback/elearning_feedback_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ElearningTestPage extends StatefulWidget {
  const ElearningTestPage({super.key});

  @override
  State<ElearningTestPage> createState() => _ElearningTestPageState();
}

class _ElearningTestPageState extends State<ElearningTestPage> {
  int? _selectedChoice;
  bool allQuestion = false;
  int currentQuestion = 0;
  List<String> answers = [];
  List<dynamic>? _testData;
  List<String>? choices;
  List<List<String>?> generatedChoices = [];
  int correctAnswer = 0;

  ElearningTestPageController elearningTestPageController = Get.find();

  @override
  void initState() {
    super.initState();
    _fetchTest();
  }

  Future<void> _fetchTest() async {
    try {
      final test = await elearningTestPageController.fetchSingleTestDetail();

      setState(() {
        _testData = test.data;
        _testData!.shuffle();

        choices = _testData![currentQuestion].choices.split(';');
        choices!.shuffle();

        generatedChoices.add((choices));
      });
    } catch (error) {
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: _testData == null
              ? const Center(child: CircularProgressIndicator())
              : Column(children: [
                  PageAppBar(type: "text", title: _testData![0].judul),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 10, left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          'Question ${currentQuestion + 1} of ${_testData![0].questionNumber == 0 ? _testData!.length : _testData![0].questionNumber}',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: semiBold),
                        ),
                        const Spacer(),
                        Countdown(
                          seconds: (_testData![0].timeLimit! ~/ 1000),
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
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: semiBold),
                            );
                          },
                          interval: const Duration(milliseconds: 1000),
                          onFinished: () {
                            // print('Timer is done!');
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          _testData![currentQuestion].question.toString(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List<Widget>.generate(
                            choices!.length,
                            (int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8), // Add vertical padding
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (answers.length > currentQuestion) {
                                        answers[currentQuestion] = generatedChoices[currentQuestion]![index].toString();
                                      } else {
                                        answers.add(generatedChoices[currentQuestion]![index].toString());
                                      }
                                      _selectedChoice = index;
                                    });
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      color: _selectedChoice == index ||
                                              (answers.length > currentQuestion
                                                  ? answers[currentQuestion] == generatedChoices[currentQuestion]![index].toString()
                                                  : false)
                                          ? primaryColor
                                          : pastelSecondaryColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0, top: 5, bottom: 5),
                                            child: Container(
                                              width: 45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _selectedChoice == index ||
                                                        (answers.length > currentQuestion
                                                            ? answers[currentQuestion] == generatedChoices[currentQuestion]![index].toString()
                                                            : false)
                                                    ? whiteColor
                                                    : primaryColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  String.fromCharCode(64 + index + 1),
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 20,
                                                    fontWeight: bold,
                                                    color: _selectedChoice == index ||
                                                            (answers.length > currentQuestion
                                                                ? answers[currentQuestion] == generatedChoices[currentQuestion]![index].toString()
                                                                : false)
                                                        ? blackColor
                                                        : whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10), // Add spacing between the circle and the text
                                          Flexible(
                                            child: Text(
                                              generatedChoices[currentQuestion]![index],
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                  color: _selectedChoice == index ||
                                                          (answers.length > currentQuestion
                                                              ? answers[currentQuestion] == generatedChoices[currentQuestion]![index].toString()
                                                              : false)
                                                      ? whiteColor
                                                      : blackColor),
                                              maxLines: 2,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentQuestion > 0) {
                                setState(() {
                                  currentQuestion--;
                                  _selectedChoice = null;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: secondaryColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Text(
                                'Previous',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                  color: whiteColor, // Customize the color of the text
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_testData![0].questionNumber == 0
                                  ? currentQuestion + 1 != _testData!.length
                                  : currentQuestion + 1 != _testData![0].questionNumber) {
                                setState(() {
                                  if (answers.length < currentQuestion + 1) {
                                    answers.add('blank');
                                  }

                                  currentQuestion++;
                                  _selectedChoice = null;
                                  if (generatedChoices.length < currentQuestion + 1) {
                                    choices = _testData![currentQuestion].choices.split(';');
                                    choices!.shuffle();
                                    generatedChoices.add((choices));
                                  }
                                });
                              } else {
                                correctAnswer = 0;

                                if (answers.length <= currentQuestion) {
                                  answers.add('blank');
                                }

                                for (int i = 0; i < answers.length; i++) {
                                  if (answers[i] == _testData![i].answer) {
                                    correctAnswer++;
                                  }
                                }

                                String score = (correctAnswer / answers.length * 100).toStringAsFixed(0);
                                // String score = '100';

                                ElearningFeedbackPageController elearningFeedbackPageController = Get.find();

                                await elearningFeedbackPageController.checkExistingUserFeedback(elearningTestPageController.elearningTestId);
                                await elearningFeedbackPageController.fetchFeedbackQuestion();

                                elearningTestPageController.score = int.parse(score);
                                elearningTestPageController.status = int.parse(score) >= elearningTestPageController.passingScore ? 'Lulus' : 'Gagal';

                                elearningTestPageController.submitTestRecord(score);

                                Get.offNamed(RouteName.elearningFeedbackPage);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Text(
                                _testData![0].questionNumber == 0
                                    ? (currentQuestion + 1 != _testData!.length ? 'Next' : 'Submit')
                                    : (currentQuestion + 1 != _testData![0].questionNumber ? 'Next' : 'Submit'),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                  color: whiteColor, // Customize the color of the text
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ])),
    );
  }
}
