import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Reactions extends StatelessWidget {
  const Reactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            // print("more!!!");
          },
          child: SvgPicture.asset(
            "assets/icons/community/ic_more_like.svg",
            width: 42,
          ),
        )
      ],
    );
  }
}
