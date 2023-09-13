import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/homepage_appbar_widget.dart';
import 'package:myplanet/views/widgets/card/card_horizontal_widget.dart';
import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';
import 'package:myplanet/theme.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {

  final HomePageController homePageController = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: homePageController.checkInternetConnection,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    const HomePageAppBar(),
                    const SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      'assets/error planet.png', // Replace this with the path to your logo image
                      width: 400, // Set the height of the logo image
                    ),
                    // Text(connected.toString()),
                  ],
                ),
              ),
            );
          }

          final bool connected = snapshot.data!;
          if (!connected) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    const HomePageAppBar(),
                    const SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      'assets/error planet.png', // Replace this with the path to your logo image
                      width: 400, // Set the height of the logo image
                    ),
                    // Text(connected.toString()),
                  ],
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const HomePageAppBar(),
                const SectionTitle(title: 'New Course'),
                FutureBuilder(
                  future: homePageController.userCoursesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loading indicator while waiting for the future to complete
                      return SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
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
                        elearningCourses.data!.sort((course1, course2) =>
                            (course2.elearningCourseId ?? 0)
                                .compareTo(course1.elearningCourseId ?? 0));
                        final coursesToShow =
                            elearningCourses.data?.take(5).toList() ?? [];

                        return SizedBox(
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: coursesToShow.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                    width:
                                        8.0), // Separator width equals padding
                            itemBuilder: (context, index) {
                              final course = coursesToShow[index];
                              return CardVerticalWidget(
                                thumbnail: course.thumbnail,
                                title: course.judul,
                                subTitle:
                                    '${(course.totalLesson ?? 0) + (course.totalTest ?? 0)} lessons • ',
                                subTitle2: course.createdBy,
                                rating: course.averageRating,
                                ratingCount: course.responseCount,
                                onTap: () {
                                  ElearningCoursePageController elearningCoursePageController = Get.find();
                                  elearningCoursePageController.setElearningCourseId(course.elearningCourseId.toString());

                                  Get.toNamed(RouteName.elearningCoursePage);
                                },
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
                const SectionTitle(title: 'Continue Learning'),
                FutureBuilder(
                  future: homePageController.userCoursesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loading indicator while waiting for the future to complete
                      return SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
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
                          height: 115,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            scrollDirection: Axis.horizontal,
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
                const SectionTitle(title: 'New Podtret'),
                FutureBuilder(
                  future: homePageController.newPodtrets,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loading indicator while waiting for the future to complete
                      return SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
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
                        var podtrets = snapshot.data!;

                        final podtretToShow =
                            podtrets.data?.take(5).toList() ?? [];

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          child: Column(
                              children:
                                  List.generate(podtretToShow.length, (index) {
                            final podtret = podtretToShow[index];
                            DateTime dateTime =
                                DateTime.parse(podtret.publishDate.toString());
                            String publishDate =
                                DateFormat('dd MMMM yyyy').format(dateTime);

                            return CardHorizontalWidget(
                              thumbnail: podtret.thumbnail,
                              category: podtret.nama,
                              title: podtret.judul,
                              subTitle:
                                  '${podtret.views}x watched • $publishDate',
                              width: 350,
                              height: 90,
                              thumbnailHeight: 65,
                              thumbnailWidht: 120,
                              titleWidth: 185,
                              subTitleWidth: 185,
                            );
                          })),
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
          );
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: bold,
              color: blackColor,
            ),
          ),
          const Spacer(),
          Text(
            'See More',
            style: TextStyle(
              color: primaryColor,
              fontWeight: bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
