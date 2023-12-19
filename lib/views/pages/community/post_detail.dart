import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myplanet/views/widgets/community/comment_primary.dart';
import 'package:myplanet/views/widgets/community/head_post.dart';
import 'package:myplanet/views/widgets/community/reactions.dart';

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
      return AppBar(
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
            const Headpost(),
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
            const Reactions(),
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [CommentPrimary(), CommentPrimary()],
            )
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          posting(),
        ],
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
            children: [header(), content()],
          ),
        ),
      ),
    );
  }
}
