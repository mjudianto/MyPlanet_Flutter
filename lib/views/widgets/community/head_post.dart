import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/community/btn_more.dart';

class Headpost extends StatelessWidget {
  const Headpost({super.key});

  @override
  Widget build(BuildContext context) {
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
        BtnMore()
      ],
    );
  }
}
