import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';

class CardVerticalWidget extends StatelessWidget {
  const CardVerticalWidget(
      {super.key, this.thumbnail, this.title, this.subTitle, this.subTitle2, this.rating, this.ratingCount, this.onTap, this.width});

  final String? thumbnail;
  final String? title;
  final String? subTitle;
  final String? subTitle2;
  final double? rating;
  final int? ratingCount;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 165,
      // width: width ?? 163,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.jpeg'), // Replace with your placeholder image asset
                    image: NetworkImage("${GlobalVariable.myplanetUrl}/${thumbnail ?? ""}"),
                    width: Get.width * 0.37,
                    height: Get.height * 0.16,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 135,
                  child: Text(
                    title ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      color: blackColor,
                      fontWeight: semiBold,
                      fontFamily: 'Poppins', // Set the font family to Poppins
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subTitle ?? "",
                  style: TextStyle(
                    fontSize: 10,
                    color: secondaryColor,
                    fontWeight: medium,
                    fontFamily: 'Poppins', // Set the font family to Poppins
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 135,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/course_createdBy_icon.png',
                        color: blackColor,
                        height: 10,
                      ),
                      const Text(' '),
                      SizedBox(
                        width: 117,
                        child: Text(
                          subTitle2 ?? "Learning & People Development",
                          style: TextStyle(
                            fontSize: 10,
                            color: blackColor,
                            fontWeight: medium,
                            fontFamily: 'Poppins', // Set the font family to Poppins
                          ),
                          overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                          maxLines: 1, // Limit the text to a single line
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
