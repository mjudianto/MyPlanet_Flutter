import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/circular_progress_widget.dart';

class CardHorizontalWidget extends StatelessWidget {
  const CardHorizontalWidget({
    super.key,
    this.category,
    this.percentage,

    this.width,
    this.height,

    this.thumbnail,
    this.thumbnailWidht,
    this.thumbnailHeight,

    this.title,
    this.titleWidth,
    this.titleHeight,

    this.subTitle,
    this.subTitleWidth,
    this.subTitleHeight,

    this.targetLocation,
  });

  final String? thumbnail;
  final String? category;
  final String? title;
  final String? subTitle;
  final double? percentage;

  final double? width;
  final double? height;

  final double? thumbnailWidht;
  final double? thumbnailHeight;

  final double? titleWidth;
  final double? titleHeight;

  final double? subTitleWidth;
  final double? subTitleHeight;

  final String? targetLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 335,
      height: height ?? 115,
      child: GestureDetector(
        onTap: () => targetLocation != null ? context.go(targetLocation.toString()) : null,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Stack(
                        children: [
                          FadeInImage(
                            placeholder: const AssetImage('assets/loading.jpeg'), // Replace with your placeholder image asset
                            image: NetworkImage("https://myplanet.enseval.com/${thumbnail ?? ""}"),
                            width: thumbnailWidht ?? 100,
                            height: thumbnailHeight ?? 85,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              category ?? "",
                              style: TextStyle(
                                fontSize: 8,
                                color: whiteColor,
                                fontWeight: bold,
                                fontFamily: 'Poppins', // Set the font family to Poppins
                              ),
                              overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                              maxLines: 1, // Limit the text to a single line
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          SizedBox(
                            width: titleWidth ?? 130,
                            child: Text(
                            title ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: semiBold,
                                fontFamily: 'Poppins', // Set the font family to Poppins
                              ),
                              overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                              maxLines: 1, // Limit the text to a single line
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(
                            width: subTitleWidth ?? 130,
                            child: Text(
                              subTitle ?? "Learning & People Development",
                              style: TextStyle(
                                fontSize: 10,
                                color: secondaryColor,
                                fontWeight: semiBold,
                                fontFamily: 'Poppins', // Set the font family to Poppins
                              ),
                              overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                              maxLines: 1, // Limit the text to a single line
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                
                Visibility(
                  visible: percentage == null ? false : true,
                  child: Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularPercentageIndicator(percentage: percentage ?? 0),
                          )
                        ],
                      ),
                    ),
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