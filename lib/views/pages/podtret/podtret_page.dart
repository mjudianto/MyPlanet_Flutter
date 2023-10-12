import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar_podtret.dart';
import 'package:myplanet/views/widgets/card/card_recomendation_podtret.dart';
import 'package:myplanet/views/widgets/card/card_new_eps_podtret.dart';
import 'package:myplanet/views/widgets/card/card_top_eps_podtret.dart';
import 'package:myplanet/views/widgets/carousel/carouselPodtret/carousel_podtret.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodtretPage extends StatefulWidget {
  const PodtretPage({super.key});

  @override
  State<PodtretPage> createState() => _PodtretPageState();
}

class _PodtretPageState extends State<PodtretPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();

    Widget rekomendasiPodtretTitle() {
      return Container(
        margin: const EdgeInsets.only(
            top: 15, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Untuk menjaga ikon di pojok kanan
          children: [
            Text(
              'Rekomendasi',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.recomendationPodtret);
              },
              child: SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                width: 14,
                height: 14,
              ),
            ),
          ],
        ),
      );
    }

    Widget rekomendasiPodtret() {
      return SizedBox(
        height: 270,
        child: SingleChildScrollView(
          // untuk scroll horizontal products
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                children: [
                  FutureBuilder(
                    future: homePageController.newPodtrets,
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
                          var podtrets = snapshot.data!;

                          final podtretToShow = podtrets.data?.toList() ?? [];
                          podtretToShow
                              .sort((a, b) => a.views!.compareTo(b.views!));

                          final top5LowestView = podtretToShow.take(5).toList();

                          return SizedBox(
                            width: Get.width,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: defaultMargin, right: 5),
                              scrollDirection: Axis.horizontal,
                              itemCount: top5LowestView.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                      vertical:
                                          4), // Adjust the right padding as needed
                                  child: CardRecomendation(
                                      item: top5LowestView[index]),
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
            ],
          ),
        ),
      );
    }

    Widget newEpsPodtretTitle() {
      return Container(
        margin: const EdgeInsets.only(
            top: 15, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Untuk menjaga ikon di pojok kanan
          children: [
            Text(
              'Episode Baru',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.newEpisodePodtret);
              },
              child: SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                width: 14,
                height: 14,
              ),
            ),
          ],
        ),
      );
    }

    Widget newEpsPodtret() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          // untuk scroll horizontal products
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                children: [
                  FutureBuilder(
                    future: homePageController.newPodtrets,
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
                          var podtrets = snapshot.data!;

                          final podtretToShow =
                              podtrets.data?.take(10).toList() ?? [];

                          return SizedBox(
                            width: Get.width,
                            height: 130,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: defaultMargin, right: 5),
                              scrollDirection: Axis.horizontal,
                              itemCount: podtretToShow.length,
                              itemBuilder: (context, index) {
                                return CardNewEps(item: podtretToShow[index]);
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
            ],
          ),
        ),
      );
    }

    Widget topEpsPodtretTitle() {
      return Container(
        margin: const EdgeInsets.only(
            top: 22, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Untuk menjaga ikon di pojok kanan
          children: [
            Text(
              'Top Episode',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.topEpisodePodtret);
              },
              child: SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                width: 14,
                height: 14,
              ),
            ),
          ],
        ),
      );
    }

    Widget topEpsPodtret() {
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FutureBuilder(
                  future: homePageController.newPodtrets,
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
                      var podtrets = snapshot.data!;

                        final podtretToShow = podtrets.data?.toList() ?? [];
                        podtretToShow
                            .sort((a, b) => b.views!.compareTo(a.views!));

                        final top10Podtret = podtretToShow.take(10).toList();

                        return SizedBox(
                          width: Get.width,
                          height: 155,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: defaultMargin, right: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: top10Podtret.length ~/ 2,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const SizedBox(width: defaultMargin),
                                  CardTopEps(
                                    item: top10Podtret[index],
                                  ),
                                  CardTopEps(
                                    item: top10Podtret[index + 1],
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    }),
              ],
            ),
          ));
    }

    Widget categories() {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 20),
        child: ScrollableTab(
          isScrollable: true,
          labelColor: blackColor,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Ngobrol Santai'),
            Tab(text: 'Sapa Mantan'),
            Tab(text: 'Kumis'),
            Tab(text: 'TKMTS'),
          ],
          indicatorColor: primaryColor,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: FutureBuilder(
                      future: homePageController.newPodtrets,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            var podtrets = snapshot.data!;

                            final podtretToShow =
                                podtrets.data?.take(5).toList() ?? [];
                            final thumbnailList = podtretToShow
                                .map((podtret) =>
                                    '${GlobalVariable.myplanetUrl}/${podtret.thumbnail}')
                                .toList();

                            return ImageSliderWithIndicator(thumbnailList);
                          } else {
                            // Handle the case when there is no data
                            return const Text('No data available.');
                          }
                        }
                      },
                    ),
                  ),
                  rekomendasiPodtretTitle(),
                  rekomendasiPodtret(),
                  newEpsPodtretTitle(),
                  newEpsPodtret(),
                  topEpsPodtretTitle(),
                  topEpsPodtret(),
                ],
              ),
            ),
            PodtretCategory(
                homePageController: homePageController,
                categoryName: 'Ngobrol Santai'),
            PodtretCategory(
                homePageController: homePageController,
                categoryName: 'Sapa Mantan'),
            PodtretCategory(
                homePageController: homePageController, categoryName: 'KUMIS'),
            PodtretCategory(
                homePageController: homePageController, categoryName: 'TKMTS'),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: const PageAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppBarPodtret(
              type: 'search',
            ),
            categories(),
          ],
        ),
      ),
    );
  }
}

class PodtretCategory extends StatelessWidget {
  const PodtretCategory({
    super.key,
    required this.homePageController,
    required this.categoryName,
  });

  final HomePageController homePageController;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
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
                  var podtrets = snapshot.data!;
            future: homePageController.newPodtrets,
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
                var podtrets = snapshot.data!;

                  final podtretToShow = podtrets.data?.toList() ?? [];
                  final filteredPodtret = podtretToShow
                      .where((item) => item.nama == categoryName)
                      .toList();

                  return SizedBox(
                    height: Get.height - 350,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: filteredPodtret.length,
                      itemBuilder: (context, index) {
                        return CardTopEps(
                          item: filteredPodtret[index],
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
