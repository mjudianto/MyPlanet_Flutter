import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/controllers/elearnings/elearning_controller.dart';
import 'package:myplanet/controllers/podtrets/podtret_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_page.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';
import 'package:myplanet/views/widgets/appBar/homepage_appbar_widget.dart';
import 'package:myplanet/views/widgets/card/card_horizontal_widget.dart';
import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';
import 'package:myplanet/theme.dart';
import 'package:intl/intl.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final HomePageController homePageController = Get.find();
  final GlobalVariable globalVariable = GlobalVariable();

  HomePage({super.key});

  Future<void> refreshPage() async {
    Get.off(
      DashboardPage(),
      transition: Transition.noTransition,
    );
    // print('yey');
  }

  List<String> imagesLocal = [];

  void showFromLocal(BuildContext context) {
    for (var campaign in GlobalVariable.campaigns.data!) {
      imagesLocal.add("${GlobalVariable.myplanetUrl}/${campaign.kontenPodtrait.toString()}");
    }

    PopupBanner(
      context: context,
      images: imagesLocal,
      fromNetwork: true,
      onClick: (index) async {
        const url = 'https://myplanet.enseval.com/downloadapk';
        try {
          if (index == 0) {
            await launchUrl(Uri.parse(url));
          }
          // if (await canLaunchUrl(Uri.parse(url)) && index == 0) {
          //   await launchUrl(Uri.parse(url));
          // } else {
          //   throw 'Could not launch $url';
          // }
        } catch (e) {
          print('Error launching URL: $e');
          // Handle the error accordingly
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    homePageController.userCoursesFuture = ElearningController.fetchUserCourses();
    homePageController.newPodtrets = PodtretController.fetchNewPodtrets();

    return Scaffold(
      body: RefreshIndicator(
        // key: refreshIndicatorKey,
        // showChildOpacityTransition: false,
        onRefresh: refreshPage,
        child: FutureBuilder(
          future: homePageController.userCoursesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  HomePageAppBar(),
                  SizedBox(
                    height: Get.height * 0.2,
                    child: Center(
                      child: DotLottieLoader.fromAsset("assets/loading.lottie", frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                        if (dotlottie != null) {
                          return Lottie.memory(dotlottie.animations.values.single, width: 250, height: 250, repeat: true);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    children: [
                      HomePageAppBar(),
                      Center(
                        child: Image.asset(
                          'assets/error planet.png', // Replace this with the path to your logo image
                          width: 400, // Set the height of the logo image
                        ),
                      ),
                      // Text(connected.toString()),
                    ],
                  ),
                ),
              );
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!GlobalVariable.posterShown) {
                showFromLocal(context);
                GlobalVariable.posterShown = true;
              }
            });

            GlobalVariable.setElearningSearchBarData(snapshot.data!.data);

            // print(GlobalVariable.elearningSearchData);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomePageAppBar(),
                  const SectionTitle(title: 'New Course'),
                  FutureBuilder(
                    future: homePageController.userCoursesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
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
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              'Error: Data Load Failed',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        if (snapshot.data != null) {
                          var elearningCourses = snapshot.data!;
                          elearningCourses.data!
                              .sort((course1, course2) => (course2.elearningCourseId ?? 0).compareTo(course1.elearningCourseId ?? 0));
                          final coursesToShow = elearningCourses.data?.take(5).toList() ?? [];

                          return Container(
                            margin: const EdgeInsets.only(
                              left: defaultMargin,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: coursesToShow.map((course) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CardVerticalWidget(
                                      thumbnail: course.thumbnail,
                                      title: course.judul,
                                      subTitle: '${(course.totalLesson ?? 0) + (course.totalTest ?? 0)} lessons • ',
                                      subTitle2: course.createdBy,
                                      rating: course.averageRating,
                                      ratingCount: course.responseCount,
                                      onTap: () {
                                        ElearningCoursePageController elearningCoursePageController = Get.find();
                                        elearningCoursePageController.setElearningCourseId(course.elearningCourseId.toString());
                                        Get.toNamed(RouteName.elearningCoursePage);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
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
                              double.parse(course2.percentage.toString()).compareTo(double.parse(course1.percentage.toString())));

                          final coursesToShow = elearningCourses.data!
                              .where((course) => course.percentage.toString() != '0.00' && course.percentage.toString() != '100.00')
                              .toList();

                          return SizedBox(
                            height: 115,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              scrollDirection: Axis.horizontal,
                              itemCount: coursesToShow.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 8.0), // Separator width equals padding
                              itemBuilder: (context, index) {
                                final course = coursesToShow[index];
                                return CardHorizontalWidget(
                                    thumbnail: course.thumbnail,
                                    category: course.kategori,
                                    title: course.judul,
                                    percentage: double.parse(course.percentage.toString()),
                                    onTap: () {
                                      ElearningCoursePageController elearningCoursePageController = Get.find();
                                      elearningCoursePageController.setElearningCourseId(course.elearningCourseId.toString());

                                      Get.toNamed(RouteName.elearningCoursePage);
                                    });
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
                          GlobalVariable.setPodtretSearchBarData(snapshot.data!.data);

                          GlobalVariable.combineSearchData();

                          var podtrets = snapshot.data!;

                          final podtretToShow = podtrets.data?.take(5).toList() ?? [];

                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                            child: Column(
                                children: List.generate(podtretToShow.length, (index) {
                              final podtret = podtretToShow[index];
                              DateTime dateTime = DateTime.parse(podtret.publishDate.toString());
                              String publishDate = DateFormat('dd MMMM yyyy').format(dateTime);

                              return CardHorizontalWidget(
                                thumbnail: podtret.thumbnail,
                                category: podtret.nama,
                                title: podtret.judul,
                                subTitle: '${podtret.views}x watched • $publishDate',
                                width: MediaQuery.of(context).size.width,
                                height: 90,
                                thumbnailHeight: 65,
                                thumbnailWidht: 120,
                                titleWidth: 200,
                                subTitleWidth: 185,
                                onTap: () {
                                  PodtretKontenController podtretKontenController = Get.find();

                                  podtretKontenController.podtret = podtret;

                                  Get.toNamed(RouteName.podtretContent);
                                },
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
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
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
