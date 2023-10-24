import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
          child: Container(
        // margin: const EdgeInsets.only(left: 10.0, top: 20.0),
        child: AppBar(
          leading: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/ic_back.svg',
                width: 14,
                height: 14,
              ),
              onPressed: () {
                Navigator.pop(
                    context); // Fungsi untuk kembali ke halaman sebelumnya
              },
            ),
          ),
          elevation: 1,
          centerTitle: true,
          backgroundColor: whiteColor,
        ),
      ));
    }

    Widget headPost() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/nanda.jpg',
              width: 40,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nanda Raditya',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'EPM - IT',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: regular,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '3j',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      '•',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SvgPicture.asset(
                      'assets/icons/ic_world.svg',
                      width: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    height: 86,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                    ),
                    // color: whiteColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: TextButton(
                                    onPressed: () {
                                      print('Terlapor!');
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: whiteColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                    ),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/community/ic_flag.svg',
                                          width: 20,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Laporkan post',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: SvgPicture.asset(
              'assets/icons/ic_more.svg',
              width: 20,
            ),
          )
        ],
      );
    }

    Widget posting() {
      return Container(
        margin: const EdgeInsets.only(left: 10, top: 12, right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            headPost(),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Fantastic Figma plugins for UX/UI designs 👇 😍Start learning UX/UI design from scratch in my online course, ebook',
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: regular),
            ),
            const SizedBox(
              height: 12,
            ),
            Image.asset(
              'assets/certificate.jpg',
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_thumbs_up_count.svg',
                      width: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '25',
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    )
                  ],
                ),
                Text(
                  '1 komentar',
                  style: secondaryTextStyle.copyWith(
                      fontSize: 12, fontWeight: regular),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            const Divider(
              color: blackColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/community/ic_thumb_up.svg',
                      width: 22,
                    ),
                    Text(
                      'Like',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostDetail(), // Ganti dengan nama yang sesuai
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_comment_2.svg',
                        width: 22,
                      ),
                      Text(
                        'Komentar',
                        style: secondaryTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Reactions",
                style: secondaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/nanda.jpg',
                        width: 42,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/ic_thumbs_up_count.svg",
                        width: 14,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/nanda.jpg',
                        width: 42,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/ic_thumbs_up_count.svg",
                        width: 14,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/nanda.jpg',
                        width: 42,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/ic_thumbs_up_count.svg",
                        width: 14,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/nanda.jpg',
                        width: 42,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/ic_thumbs_up_count.svg",
                        width: 14,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/nanda.jpg',
                        width: 42,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/ic_thumbs_up_count.svg",
                        width: 14,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/nanda.jpg',
                        width: 42,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/ic_thumbs_up_count.svg",
                        width: 14,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    print("more!!!");
                  },
                  child: SvgPicture.asset(
                    "assets/icons/community/ic_more_like.svg",
                    width: 42,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Komentar",
                style: secondaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: regular),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/nanda.jpg',
                    width: 42,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: pastelSecondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nanda Raditya',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Text(
                                  'EPM - IT',
                                  style: secondaryTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: regular,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 86,
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                      ),
                                      // color: whiteColor,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        print('Terlapor!');
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            whiteColor,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 20,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/community/ic_flag.svg',
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            'Laporkan post',
                                                            style:
                                                                blackTextStyle
                                                                    .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  semiBold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        print('Terlapor!');
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            whiteColor,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 20,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/ic_trash.svg',
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            'Hapus',
                                                            style:
                                                                blackTextStyle
                                                                    .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  semiBold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/ic_more.svg',
                                width: 18,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Good tips for designer!",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: regular),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [posting()],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: const PageAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [header(), content()],
          ),
        ),
      ),
    );
  }
}
