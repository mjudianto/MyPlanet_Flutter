import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/widgets/card/card_top_eps_podtret.dart';

class NewEpsPodtret extends StatelessWidget {
  const NewEpsPodtret({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(top: 18),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: blackColor,
            ),
          ),
          title: Padding(
            padding:
                const EdgeInsets.only(top: 18), // Atur padding atas untuk Text
            child: Text(
              'Episode Baru',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      HomePageController homePageController = Get.find();

      return ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // * LIST ITEM
          Container(
            margin: const EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                      final podtretToShow = podtrets.data?.toList() ?? [];

                      return SizedBox(
                        height: Get.height - 175,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: podtretToShow.length,
                          itemBuilder: (context, index) {
                            return CardTopEps(
                              item: podtretToShow[index],
                            );
                          },
                        ),
                      );


                      
                    }
                  }
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(),
      body: content(),
    );
  }
}
