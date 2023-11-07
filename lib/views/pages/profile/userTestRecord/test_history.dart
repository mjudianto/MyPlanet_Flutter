import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/profile/userTestRecord/test_history_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';

class TestHistory extends StatelessWidget {
  TestHistory({Key? key}) : super(key: key);

  final TestHistoryPageController testHistoryPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Container(
        margin: const EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
        child: FutureBuilder(
          future: testHistoryPageController.fetchUserTestRecord(),
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
                final userTestRecord = snapshot.data!.data;

                return SizedBox(
                  height: Get.height * 0.73,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: userTestRecord?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final testRecord = userTestRecord?[index]; // Replace with how you access your data

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${testRecord!.judulTest}", // Replace with how you access the title
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                testRecord.attempt.toString(), // Replace with how you access the count
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
                                '${testRecord.status.toString()} - ${testRecord.score}', // Replace with how you access the subtitle
                                style: secondaryTextStyle.copyWith(
                                    fontSize: 12, fontWeight: bold, color: testRecord.status.toString() == 'Lulus' ? successColor : dangerColor),
                              ),
                              Text(
                                testRecord.date.toString(), // Replace with how you access the date
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
                title: 'Test History',
              ),
              content()
            ],
          ),
        ),
      ),
    );
  }
}
