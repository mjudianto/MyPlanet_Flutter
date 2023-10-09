import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';

// ignore: must_be_immutable
class PodtretContent extends StatelessWidget {
  final PodtretKontenController podtretKontenController = Get.find();
  late CustomVideoPlayerController customVideoPlayerController;

  PodtretContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Call initializeVideoPlayer only once when the widget is first built
    // if (!podtretKontenController.isVideoInitialized.value) {

    // }
    podtretKontenController.initializeVideoPlayer();

    Widget likeBtn() {
      return InkWell(
        onTap: () {
          print("klik kluk!");
        },
        child: Container(
          margin: const EdgeInsets.only(top: 4.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_thumb_up.svg',
                  width: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "100",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget likeBtnActive() {
      return InkWell(
        onTap: () {
          print("klik kluk!");
        },
        child: Container(
          margin: const EdgeInsets.only(top: 4.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_thumb_up_active.svg',
                  width: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "100",
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget vidio() {
      return InkWell(
        onTap: () {
          print("klik Vidio!");
        },
        child: Container(
          // margin: const EdgeInsets.only(top: 4.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Column(
              children: [
                Text(
                  "Vidio",
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget audio() {
      return InkWell(
        onTap: () {
          print("klik Audio!");
        },
        child: Container(
          // margin: const EdgeInsets.only(top: 4.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: whiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Column(
              children: [
                Text(
                  "Audio",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget replyComment() {
      return InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_back.svg',
                                  ),
                                ),
                              ),
                              Text(
                                'Balasan',
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: medium,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),

                        // Scroll Vertical
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 75),
                            child: SingleChildScrollView(
                              // Scroll Vertical
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                'assets/nanda.jpg',
                                                width: 30,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ardi • 3 days ago',
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                      fontSize: 12,
                                                      fontWeight: regular,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 12,
                                                      fontWeight: regular,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 60,
                                          right: 20,
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                'assets/nanda.jpg',
                                                width: 30,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ardi • 3 days ago',
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                      fontSize: 12,
                                                      fontWeight: regular,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 12,
                                                      fontWeight: regular,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Scroll Vertical End
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color:
                          whiteColor, // Atur warna latar belakang sesuai kebutuhan
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/nanda.jpg',
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.3), // Warna shadow
                                    spreadRadius: 2, // Radius penyebaran shadow
                                    blurRadius: 3, // Radius blur shadow
                                    offset:
                                        Offset(3, 3), // Offset shadow (x, y)
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    100), // Mengatur border radius sesuai kebutuhan
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Tambahkan komentar",
                                  hintStyle: secondaryTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: whiteColor,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_comment.svg',
              width: 16,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '1 balasan',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget comment() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      height: 600,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Komentar',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: medium,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Scroll Vertical
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 75),
                              child: SingleChildScrollView(
                                // Scroll Vertical
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipOval(
                                            child: Image.asset(
                                              'assets/nanda.jpg',
                                              width: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Nanda Raditya • 3 days ago',
                                                  style: secondaryTextStyle
                                                      .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: regular,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: regular,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                replyComment(),
                                                // const SizedBox(
                                                //   height: 8,
                                                // ),
                                                // Text(
                                                //   '1 balasan',
                                                //   style:
                                                //       primaryTextStyle.copyWith(
                                                //     fontSize: 12,
                                                //     fontWeight: semiBold,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Scroll Vertical End
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color:
                            whiteColor, // Atur warna latar belakang sesuai kebutuhan
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/nanda.jpg',
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.3), // Warna shadow
                                      spreadRadius:
                                          2, // Radius penyebaran shadow
                                      blurRadius: 3, // Radius blur shadow
                                      offset:
                                          Offset(3, 3), // Offset shadow (x, y)
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      100), // Mengatur border radius sesuai kebutuhan
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Tambahkan komentar",
                                    hintStyle: secondaryTextStyle.copyWith(
                                      fontSize: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: whiteColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            primary: whiteColor, // Warna latar belakang
            elevation: 2, // Ketinggian bayangan tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Text(
                      "Comments",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "7",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 8,
                ),
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: "Tambahkan komentar",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: secondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget anotherEpisode() {
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 38),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            'assets/podtret/thumbnail/eps72.png',
                            width: 122,
                            height: 69,
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Jarak antara thumbnail dan teks
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      100), // Mengatur border radius
                                  color: primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                    'Ngobrol Santai',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 8,
                                      fontWeight: medium,
                                      color:
                                          whiteColor, // Ganti warna teks sesuai kebutuhan
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Eps 72 : Jawabin Pertanyaan Lucu Gens dari IG',
                                style: blackTextStyle.copyWith(
                                  fontSize: 11,
                                  fontWeight: semiBold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '349x Watching • 21 July 2023',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 8,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              )));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    // Video player widget
                    Positioned.fill(
                      child: Obx(() {
                        final isVideoInitialized =
                            podtretKontenController.isVideoInitialized.value;

                        if (isVideoInitialized) {
                          final videoPlayerController =
                              podtretKontenController.videoPlayerController;

                          customVideoPlayerController =
                              CustomVideoPlayerController(
                            context: context,
                            videoPlayerController: videoPlayerController,
                          );
                        }

                        return isVideoInitialized
                            ? CustomVideoPlayer(
                                customVideoPlayerController:
                                    customVideoPlayerController,
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              );
                      }),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.07,
                      left: 20,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: IconButton(
                            iconSize: 16,
                            color: blackColor,
                            icon: const Icon(Icons.arrow_back_ios_new),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      return Visibility(
                        visible:
                            !podtretKontenController.isVideoInitialized.value,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eps 66 : Episode Paling Lucu',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '567 ditonton • 21 July 2023',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    likeBtn(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: whiteColor, // Warna latar belakang
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            vidio(),
                            audio(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              comment(),
              const SizedBox(
                height: 10,
              ),
              anotherEpisode(),
              anotherEpisode(),
              anotherEpisode(),
              anotherEpisode(),
            ],
          ),
        ),
      ),
    );
  }
}
