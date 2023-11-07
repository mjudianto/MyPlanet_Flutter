import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/controllers/elearnings/elearning_controller.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
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
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: (filteredAndSortedCourses.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final course1 = filteredAndSortedCourses[index * 2];
                    final course2 = (index * 2 + 1 < filteredAndSortedCourses.length) ? filteredAndSortedCourses[index * 2 + 1] : null;

                    return SizedBox(
                      height: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: CardVerticalWidget(
                              thumbnail: course1.thumbnail,
                              title: course1.judul,
                              subTitle: '${(course1.totalLesson ?? 0) + (course1.totalTest ?? 0)} lessons • ',
                              subTitle2: course1.createdBy,
                              rating: course1.averageRating,
                              ratingCount: course1.responseCount,
                              onTap: () {
                                ElearningCoursePageController elearningCoursePageController = Get.find();
                                elearningCoursePageController.setElearningCourseId(course1.elearningCourseId.toString());

                                Get.toNamed(RouteName.elearningCoursePage);
                              },
                            ),
                          ),
                          if (course2 != null) const SizedBox(width: 8),
                          if (course2 != null)
                            Expanded(
                              child: CardVerticalWidget(
                                thumbnail: course2.thumbnail,
                                title: course2.judul,
                                subTitle: '${(course2.totalLesson ?? 0) + (course2.totalTest ?? 0)} lessons • ',
                                subTitle2: course2.createdBy,
                                rating: course2.averageRating,
                                ratingCount: course2.responseCount,
                                onTap: () {
                                  ElearningCoursePageController elearningCoursePageController = Get.find();
                                  elearningCoursePageController.setElearningCourseId(course2.elearningCourseId.toString());

                                  Get.toNamed(RouteName.elearningCoursePage);
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Text('No data available.');
          }
        }
      },
    );
  }
}
