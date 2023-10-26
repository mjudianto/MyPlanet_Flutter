import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/podtrets/podtret_comment_models.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/home/home_page_controller.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';
import 'package:myplanet/views/widgets/card/card_horizontal_widget.dart';

// ignore: must_be_immutable
class PodtretContent extends StatelessWidget {
  final PodtretKontenController podtretKontenController = Get.find();
  final HomePageController homePageController = Get.find();
  late CustomVideoPlayerController customVideoPlayerController;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();


  PodtretContent({super.key});

  @override
  Widget build(BuildContext context) {
    podtretKontenController.initializeVideoPlayer();
    RxBool liked = RxBool(podtretKontenController.podtret.likeState == 1);
    Rx<Future<PodtretComment>> podtretComments = podtretKontenController.fetchPodtretComments(podtretKontenController.podtret.podtretId.toString()).obs;
    RxList<Reply>? commentReply;
    

    Widget vidio() {
      return InkWell(
        onTap: () {
          // print("klik Vidio!");
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
                  "Video",
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
          // print("klik Audio!");
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

    Widget replyComment(PodtretCommentElement? comment) {
      // print(comment?.reply);
      
      return InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
                commentReply = comment.reply?.obs;
                return Container(
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
                                padding: const EdgeInsets.all(8.0),
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
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),

                      // Scroll Vertical
                      SizedBox(
                        height: 300,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 75),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => Image.asset(
                                              'assets/loading.jpeg', // Placeholder image
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (context, url, error) => Image.asset(
                                              'assets/icons/avatar.png', // Default image for errors
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl: '${GlobalVariable.myplanetUrl}/userAssets/Foto_emos/${comment.userNik}.png',
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.7,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${comment.nama.toString()} • ${podtretKontenController.timeCommentUploaded(comment.uploadDate.toString())}',
                                                style: secondaryTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: regular,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                comment.comment.toString(),
                                                style: blackTextStyle.copyWith(
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
                                  Obx(() => 
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: commentReply!.map((reply) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 60,
                                            right: 20,
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipOval(
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) => Image.asset(
                                                    'assets/loading.jpeg', // Placeholder image
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    'assets/icons/avatar.png', // Default image for errors
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  imageUrl: '${GlobalVariable.myplanetUrl}/userAssets/Foto_emos/${reply.userNik}.png',
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${reply.nama.toString()} • ${podtretKontenController.timeCommentUploaded(reply.uploadDate.toString())}',
                                                      style: secondaryTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight: regular,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      reply.comment.toString(),
                                                      style: blackTextStyle.copyWith(
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
                                        );
                                      }).toList(),
                                    )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),


                        // Scroll Vertical End

                      Container(
                        color:
                            whiteColor, // Atur warna latar belakang sesuai kebutuhan
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Image.asset(
                                  'assets/loading.jpeg', // Placeholder image
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  'assets/icons/avatar.png', // Default image for errors
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                imageUrl: '${GlobalVariable.myplanetUrl}/userAssets/Foto_emos/${GlobalVariable.userData['user']['empnik']}.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.3), // Warna shadow
                                    spreadRadius: 3, // Radius penyebaran shadow
                                    blurRadius: 3, // Radius blur shadow
                                    offset:
                                        const Offset(3, 3), // Offset shadow (x, y)
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    100), // Mengatur border radius sesuai kebutuhan
                              ),
                              child: SizedBox(
                                height: 50,
                                width: Get.width * 0.75,
                                child: TextFormField(
                                  controller: replyController,
                                  onFieldSubmitted: (value) {
                                    Reply newReply = Reply();
                                    newReply.userNik = GlobalVariable.userData['user']['empnik'];
                                    newReply.uploadDate = DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
                                    newReply.nama = GlobalVariable.userData['user']['EmpName'];
                                    newReply.comment = value;

                                    podtretKontenController.submitPodtretCommentReply(comment.podtretCommentId.toString(), value);
                                    podtretComments.value = podtretKontenController.fetchPodtretComments(podtretKontenController.podtret.podtretId.toString());

                                    replyController.clear();
                                    commentReply?.add(newReply);
                                  },
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
                        )
                      )
                    ],
                  ),
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
            Visibility(
              visible: comment!.reply!.isNotEmpty,
              child: Text(
                '${comment.reply?.length} balasan',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget comment() {
      return Builder(
        builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
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
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Obx(() => 
                            FutureBuilder(
                            future: podtretComments.value, // Replace with the function that fetches your data
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                // You can return a loading indicator here if needed
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // Handle the error here
                                return Text('Error: ${snapshot.error}');
                              } else {
                                // Assuming your data is a list of YourDataType objects
                                var comments = snapshot.data;
                                
                                if (comments?.podtretComment == null) {
                                  return const SizedBox(
                                    height: 300,
                                    child: Center(child: Text('No Comment'))
                                  );
                                }

                                return SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: comments!.podtretComment?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipOval(
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) => Image.asset(
                                                  'assets/loading.jpeg', // Placeholder image
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget: (context, url, error) => Image.asset(
                                                  'assets/icons/avatar.png', // Default image for errors
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                                imageUrl: '${GlobalVariable.myplanetUrl}/userAssets/Foto_emos/${comments.podtretComment![index].userNik}.png',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${comments.podtretComment![index].nama.toString()} • ${podtretKontenController.timeCommentUploaded(comments.podtretComment![index].uploadDate.toString())}',
                                                  style: secondaryTextStyle.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: regular,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  comments.podtretComment![index].comment.toString(), // Replace with how you access the text from your data
                                                  style: blackTextStyle.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: regular,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                replyComment(comments.podtretComment![index]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          )
                          ),
                          Container(
                            color:
                                whiteColor, // Atur warna latar belakang sesuai kebutuhan
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Image.asset(
                                      'assets/loading.jpeg', // Placeholder image
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/icons/avatar.png', // Default image for errors
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                    imageUrl: '${GlobalVariable.myplanetUrl}/userAssets/Foto_emos/${GlobalVariable.userData['user']['empnik']}.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Warna shadow
                                        spreadRadius: 3, // Radius penyebaran shadow
                                        blurRadius: 3, // Radius blur shadow
                                        offset:
                                            const Offset(3, 3), // Offset shadow (x, y)
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        100), // Mengatur border radius sesuai kebutuhan
                                  ),
                                  child: SizedBox(
                                    height: 50,
                                    width: Get.width * 0.75,
                                    child: TextFormField(
                                      controller: commentController,
                                      onFieldSubmitted: (value) {
                                        podtretKontenController.submitPodtretComment(podtretKontenController.podtret.podtretId.toString(), value);
                                        Timer(const Duration(seconds: 1), () {
                                          podtretComments.value = podtretKontenController.fetchPodtretComments(podtretKontenController.podtret.podtretId.toString());
                                        });
                                        commentController.clear();
                                      },
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
                            )
                          )
                        ]
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: whiteColor, // Warna latar belakang
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
                        Obx(() => 
                          Text(
                            podtretKontenController.totalComment.value.toString(),
                            style: secondaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          )
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
                        hintStyle: const TextStyle(
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
      );
    }

    // Widget anotherEpisode() {
    //   return Container(
    //       margin: const EdgeInsets.only(top: 10),
    //       child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: GestureDetector(
    //             onTap: () {},
    //             child: Container(
    //                 width: 300,
    //                 margin: const EdgeInsets.only(right: 38),
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     ClipRRect(
    //                       borderRadius: const BorderRadius.all(Radius.circular(20)),
    //                       child: Image.asset(
    //                         'assets/podtret/thumbnail/eps66.jpg',
    //                         width: 122,
    //                         height: 69,
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                         width: 10), // Jarak antara thumbnail dan teks
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                           margin: const EdgeInsets.only(top: 4.5),
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(
    //                                 100), // Mengatur border radius
    //                             color: primaryColor,
    //                           ),
    //                           child: Padding(
    //                             padding: const EdgeInsets.symmetric(
    //                                 horizontal: 10, vertical: 4),
    //                             child: Text(
    //                               'Ngobrol Santai',
    //                               style: blackTextStyle.copyWith(
    //                                 fontSize: 8,
    //                                 fontWeight: medium,
    //                                 color:
    //                                     whiteColor, // Ganti warna teks sesuai kebutuhan
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         const SizedBox(height: 4),
    //                         Text(
    //                           'Eps 72 : Jawabin Pertanyaan Lucu Gens dari IG',
    //                           style: blackTextStyle.copyWith(
    //                             fontSize: 11,
    //                             fontWeight: semiBold,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                           maxLines: 1,
    //                         ),
    //                         const SizedBox(height: 4),
    //                         Text(
    //                           '349x Watching • 21 July 2023',
    //                           style: secondaryTextStyle.copyWith(
    //                             fontSize: 8,
    //                             fontWeight: regular,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 )),
    //           )));
    // }

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
                margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      podtretKontenController.podtret.judul,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                       '${podtretKontenController.podtret.views}x watched • ${podtretKontenController.publishDate()}',
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
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          podtretKontenController.likePodtret(podtretKontenController.podtret.podtretId.toString());
                          if (liked.value == true) {
                            liked.value = false;
                            podtretKontenController.podtret.totalLike = (int.parse(podtretKontenController.podtret.totalLike)-1).toString();
                          } else {
                            liked.value = true;
                            podtretKontenController.podtret.totalLike = (int.parse(podtretKontenController.podtret.totalLike)+1).toString();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 4.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: liked.value ? primaryColor : whiteColor,
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
                                  liked.value ? 'assets/icons/ic_thumb_up_active.svg' : 'assets/icons/ic_thumb_up.svg',
                                  width: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  podtretKontenController.podtret.totalLike.toString(),
                                  style: liked.value ? 
                                  whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: regular,
                                  )
                                  : blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: regular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          vidio(),
                          audio(),
                        ],
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
              // anotherEpisode(),
              // anotherEpisode(),
              // anotherEpisode(),
              // anotherEpisode(),
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
                          podtrets.data?.take(8).toList() ?? [];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Column(
                            children:
                                List.generate(podtretToShow.length, (index) {
                          final podtret = podtretToShow[index];
                          
                          String publishDate = podtretKontenController.publishDate();

                          return CardHorizontalWidget(
                            thumbnail: podtret.thumbnail,
                            category: podtret.nama,
                            title: podtret.judul,
                            subTitle:
                                '${podtret.views}x watched • $publishDate',
                            width: 370,
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
        ),
      ),
    );
  }
}
