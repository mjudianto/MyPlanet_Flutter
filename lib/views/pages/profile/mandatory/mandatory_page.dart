import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar_podtret.dart';
import 'package:myplanet/views/widgets/card/card_horizontal_widget.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';

class Mandatory extends StatelessWidget {
  const Mandatory({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.find();
    
    return Scaffold(
      body: Column(
        children: [
          const AppBarPodtret(
              type: 'text',
              title: 'Mandatory',
            ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 0, right: 10, bottom: 20),
              child: ScrollableTab(
                isScrollable: true,
                labelColor: blackColor,
                tabs: const [
                  Tab(text: 'On Progress'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Uncomplete'),
                ],
                indicatorColor: primaryColor,
                children: [
                  FutureBuilder(
                    future: homePageController.userCoursesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while waiting for the future to complete
                        return SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: DotLottieLoader.fromAsset(
                              "assets/loading.lottie",
                              frameBuilder:(BuildContext ctx, DotLottie? dotlottie) {
                              if (dotlottie != null) {
                                return Lottie.memory(
                                    dotlottie.animations.values.single,
                                    width: 250,
                                    height: 250,
                                    repeat: true);
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
                          var elearningCourses = snapshot.data!;
                          elearningCourses.data!.sort((course1, course2) => double
                                  .parse(course2.percentage.toString())
                              .compareTo(
                                  double.parse(course1.percentage.toString())));

                          final coursesToShow = elearningCourses.data!
                              .where((course) =>
                                  course.percentage.toString() != '0.00' &&
                                  course.percentage.toString() != '100.00')
                              .toList();

                          return SizedBox(
                            height: Get.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              scrollDirection: Axis.vertical,
                              itemCount: coursesToShow.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                      width:
                                          8.0), // Separator width equals padding
                              itemBuilder: (context, index) {
                                final course = coursesToShow[index];
                                return CardHorizontalWidget(
                                  thumbnail: course.thumbnail,
                                  category: course.kategori,
                                  title: course.judul,
                                  percentage:
                                      double.parse(course.percentage.toString()),
                                  onTap: () {
                                    ElearningCoursePageController elearningCoursePageController = Get.find();
                                    elearningCoursePageController.setElearningCourseId(course.elearningCourseId.toString());
                                    
                                    Get.toNamed(RouteName.elearningCoursePage);
                                  }
                                );
                              },
                            ),
                          );
                        } else {
                          // Handle the case when there is no data
                          return const Text('No data available.');
                        }
                      }
                    },
                  ),

                  
                  FutureBuilder(
                    future: homePageController.userCoursesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while waiting for the future to complete
                        return SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: DotLottieLoader.fromAsset(
                              "assets/loading.lottie",
                              frameBuilder:(BuildContext ctx, DotLottie? dotlottie) {
                              if (dotlottie != null) {
                                return Lottie.memory(
                                    dotlottie.animations.values.single,
                                    width: 250,
                                    height: 250,
                                    repeat: true);
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
                          var elearningCourses = snapshot.data!;
                          elearningCourses.data!.sort((course1, course2) => double
                                  .parse(course2.percentage.toString())
                              .compareTo(
                                  double.parse(course1.percentage.toString())));

                          final coursesToShow = elearningCourses.data!
                              .where((course) =>
                                  course.percentage.toString() == '100.00')
                              .toList();

                          return SizedBox(
                            height: Get.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              scrollDirection: Axis.vertical,
                              itemCount: coursesToShow.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                      width:
                                          8.0), // Separator width equals padding
                              itemBuilder: (context, index) {
                                final course = coursesToShow[index];
                                return CardHorizontalWidget(
                                  thumbnail: course.thumbnail,
                                  category: course.kategori,
                                  title: course.judul,
                                  percentage:
                                      double.parse(course.percentage.toString()),
                                  onTap: () {
                                    ElearningCoursePageController elearningCoursePageController = Get.find();
                                    elearningCoursePageController.setElearningCourseId(course.elearningCourseId.toString());
                                    
                                    Get.toNamed(RouteName.elearningCoursePage);
                                  }
                                );
                              },
                            ),
                          );
                        } else {
                          // Handle the case when there is no data
                          return const Text('No data available.');
                        }
                      }
                    },
                  ),
                  

                  FutureBuilder(
                    future: homePageController.userCoursesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while waiting for the future to complete
                        return SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: DotLottieLoader.fromAsset(
                              "assets/loading.lottie",
                              frameBuilder:(BuildContext ctx, DotLottie? dotlottie) {
                              if (dotlottie != null) {
                                return Lottie.memory(
                                    dotlottie.animations.values.single,
                                    width: 250,
                                    height: 250,
                                    repeat: true);
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
                          var elearningCourses = snapshot.data!;
                          elearningCourses.data!.sort((course1, course2) => double
                                  .parse(course2.percentage.toString())
                              .compareTo(
                                  double.parse(course1.percentage.toString())));

                          final coursesToShow = elearningCourses.data!
                              .where((course) =>
                                  course.percentage.toString() == '0.00')
                              .toList();

                          return SizedBox(
                            height: Get.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              scrollDirection: Axis.vertical,
                              itemCount: coursesToShow.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                      width:
                                          8.0), // Separator width equals padding
                              itemBuilder: (context, index) {
                                final course = coursesToShow[index];
                                return CardHorizontalWidget(
                                  thumbnail: course.thumbnail,
                                  category: course.kategori,
                                  title: course.judul,
                                  percentage:
                                      double.parse(course.percentage.toString()),
                                  onTap: () {
                                    ElearningCoursePageController elearningCoursePageController = Get.find();
                                    elearningCoursePageController.setElearningCourseId(course.elearningCourseId.toString());
                                    
                                    Get.toNamed(RouteName.elearningCoursePage);
                                  }
                                );
                              },
                            ),
                          );
                        } else {
                          // Handle the case when there is no data
                          return const Text('No data available.');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}