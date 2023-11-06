import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/community/post_detail.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
// import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget createStatus() {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/nanda.jpg',
                width: 40,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Start a Post',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: medium,
                    color: secondaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color:
                          secondaryColor, // Ganti dengan warna border yang Anda inginkan
                    ),
                  ),
                  filled: true,
                  fillColor:
                      whiteColor, // Ganti dengan warna latar belakang yang Anda inginkan
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              'assets/icons/ic_media.svg',
              width: 24,
            ),
          ],
        ),
      );
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
                                SizedBox(
                                  height: 30,
                                  child: TextButton(
                                    onPressed: () {
                                      // print('Terlapor!');
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
        margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PostDetail(), // Ganti dengan nama yang sesuai
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '...lebih banyak',
                  style: secondaryTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                ),
              ),
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PostDetail(), // Ganti dengan nama yang sesuai
                      ),
                    );
                  },
                  child: Text(
                    '1 komentar',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                )
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
                            const PostDetail(), // Ganti dengan nama yang sesuai
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
            )
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: PageAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageAppBar(
                type: 'logo',
              ),
              createStatus(),
              posting(),
              createStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
