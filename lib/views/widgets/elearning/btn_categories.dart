import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myplanet/theme.dart';

class BtnCategories extends StatelessWidget {
  const BtnCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: defaultMargin, right: defaultMargin, top: 15, bottom: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: primaryColor,
              ),
              child: Text(
                "All",
                style:
                    whiteTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "General",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "QA & Security",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "Technical",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "Soft Skill",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "SOP IK",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "InnoChamp",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: pastelSecondaryColor,
                ),
                color: whiteColor,
              ),
              child: Text(
                "Enseval Bootcamp",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
