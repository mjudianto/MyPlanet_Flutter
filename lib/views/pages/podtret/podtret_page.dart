import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar_podtret.dart';
import 'package:myplanet/views/widgets/card/card_recomendation_podtret.dart';
import 'package:myplanet/views/widgets/card/card_new_eps_podtret.dart';
import 'package:myplanet/views/widgets/card/card_top_eps_podtret.dart';
import 'package:myplanet/views/widgets/carousel_podtret.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodtretPage extends StatefulWidget {
  const PodtretPage({super.key});

  @override
  State<PodtretPage> createState() => _PodtretPageState();
}

class _PodtretPageState extends State<PodtretPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 14,
              height: 14,
            ),
          ],
        ),
      );
    }

    Widget rekomendasiPodtret() {
      return const SizedBox(
        height: 270,
        child: SingleChildScrollView(
          // untuk scroll horizontal products
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: [
                  CardRecomendation(),
                  CardRecomendation(),
                  CardRecomendation(),
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
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 14,
              height: 14,
            ),
          ],
        ),
      );
    }

    Widget newEpsPodtret() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: const SingleChildScrollView(
          // untuk scroll horizontal products
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: [
                  CardNewEps(),
                  CardNewEps(),
                  CardNewEps(),
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
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 14,
              height: 14,
            ),
          ],
        ),
      );
    }

    Widget topEpsPodtret() {
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: defaultMargin),
                    CardTopEps(),
                    CardTopEps(),
                    CardTopEps(),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(width: defaultMargin),
                    CardTopEps(),
                    CardTopEps(),
                    CardTopEps(),
                  ],
                ),
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
                    child: ImageSliderWithIndicator(const [
                      'assets/podtret/thumbnail/eps80.png',
                      'assets/podtret/thumbnail/eps79.jpg',
                      'assets/podtret/thumbnail/eps78.png',
                      'assets/podtret/thumbnail/eps77.jpg',
                      'assets/podtret/thumbnail/eps76.jpg',
                    ]),
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
            const Center(child: Text('Santai Content')),
            const Center(child: Text('Seram Content')),
            const Center(child: Text('Politik Content')),
            const Center(child: Text('Olahraga Content')),
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
