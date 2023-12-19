import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/community/post_detail.dart';
import 'package:myplanet/views/widgets/community/head_post.dart';

class PostingContent extends StatelessWidget {
  const PostingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
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
                          PostDetail(), // Ganti dengan nama yang sesuai
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
          )
        ],
      ),
    );
  }
}
