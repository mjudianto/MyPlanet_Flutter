import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/controllers/elearnings/elearning_controller.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_page.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';

class ElearningPage extends StatefulWidget {
  const ElearningPage({super.key});

  @override
  State<ElearningPage> createState() => _ElearningPageState();
}

class _ElearningPageState extends State<ElearningPage> {
  Future<ElearningCourse>? _userCoursesFuture;

  Future<void> refreshPage() async {
    Get.off(
      DashboardPage(),
      transition: Transition.noTransition,
    );
  }

  @override
  void initState() {
    super.initState();

    _userCoursesFuture = ElearningController.fetchUserCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PageAppBar(
          type: 'search',
        ),
        backgroundColor: backgroundColor,
        body: DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ButtonsTabBar(
                  borderColor: pastelSecondaryColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  borderWidth: 1,
                  unselectedBorderColor: pastelSecondaryColor,
                  backgroundColor: primaryColor,
                  unselectedBackgroundColor: whiteColor,
                  unselectedLabelStyle: const TextStyle(color: blackColor),
                  radius: 100,
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "General",
                    ),
                    Tab(
                      text: "QA & Security",
                    ),
                    Tab(
                      text: "Technical",
                    ),
                    Tab(
                      text: "Soft Skill",
                    ),
                    Tab(
                      text: "Enseval Bootcamp",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: courseByKategori('all'),
                    ),
                    Center(
                      child: courseByKategori('General'),
                    ),
                    Center(
                      child: courseByKategori('QA & Security'),
                    ),
                    Center(
                      child: courseByKategori('Technical'),
                    ),
                    Center(
                      child: courseByKategori('Soft Skill'),
                    ),
                    Center(
                      child: courseByKategori('Enseval Bootcamp'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  FutureBuilder<ElearningCourse> courseByKategori(String kategori) {
    return FutureBuilder(
      future: _userCoursesFuture,
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
          if (snapshot.data != null) {
            var elearningCourses = snapshot.data!;

            List<Datum> filteredAndSortedCourses = elearningCourses.data != null && kategori != 'all'
                ? elearningCourses.data!.where((course) => course.kategori.toString().toLowerCase() == kategori.toLowerCase()).toList()
                : elearningCourses.data?.toList() ?? [];

            filteredAndSortedCourses.sort((course1, course2) => (course2.elearningCourseId ?? 0).compareTo(course1.elearningCourseId ?? 0));

            return SizedBox(
              height: 0.70 * MediaQuery.of(context).size.height,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: (filteredAndSortedCourses.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      int leftIndex = index * 2;
                      int rightIndex = leftIndex + 1;
                      bool hasRightCard = rightIndex < filteredAndSortedCourses.length;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (leftIndex < filteredAndSortedCourses.length)
                            CardVerticalWidget(
                              thumbnail: filteredAndSortedCourses[leftIndex].thumbnail,
                              // width: 149,
                              title: filteredAndSortedCourses[leftIndex].judul,
                              subTitle:
                                  '${(filteredAndSortedCourses[leftIndex].totalLesson ?? 0) + (filteredAndSortedCourses[leftIndex].totalTest ?? 0)} lessons • ',
                              subTitle2: filteredAndSortedCourses[leftIndex].createdBy,
                              rating: filteredAndSortedCourses[leftIndex].averageRating,
                              ratingCount: filteredAndSortedCourses[leftIndex].responseCount,
                              onTap: () {
                                ElearningCoursePageController elearningCoursePageController = Get.find();
                                elearningCoursePageController.setElearningCourseId(filteredAndSortedCourses[leftIndex].elearningCourseId.toString());

                                Get.toNamed(RouteName.elearningCoursePage);
                              },
                            ),
                          if (hasRightCard)
                            CardVerticalWidget(
                              thumbnail: filteredAndSortedCourses[rightIndex].thumbnail,
                              width: 149,
                              title: filteredAndSortedCourses[rightIndex].judul,
                              subTitle:
                                  '${(filteredAndSortedCourses[rightIndex].totalLesson ?? 0) + (filteredAndSortedCourses[rightIndex].totalTest ?? 0)} lessons • ',
                              subTitle2: filteredAndSortedCourses[rightIndex].createdBy,
                              rating: filteredAndSortedCourses[rightIndex].averageRating,
                              ratingCount: filteredAndSortedCourses[rightIndex].responseCount,
                              onTap: () {
                                ElearningCoursePageController elearningCoursePageController = Get.find();
                                elearningCoursePageController.setElearningCourseId(filteredAndSortedCourses[rightIndex].elearningCourseId.toString());

                                Get.toNamed(RouteName.elearningCoursePage);
                              },
                            ),
                        ],
                      );
                    },
                  )),
            );
          } else {
            return const Text('No data available.');
          }
        }
      },
    );
  }
}
