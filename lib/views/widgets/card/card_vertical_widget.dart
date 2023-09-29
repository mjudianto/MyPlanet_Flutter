import 'package:flutter/material.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';

class CardVerticalWidget extends StatelessWidget {
  const CardVerticalWidget({
    super.key,
    this.thumbnail,
    this.title,
    this.subTitle,
    this.subTitle2,
    this.rating,
    this.ratingCount,
    this.onTap,
  });

  final String? thumbnail;
  final String? title;
  final String? subTitle;
  final String? subTitle2;
  final double? rating;
  final int? ratingCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading.jpeg'), // Replace with your placeholder image asset
                        image: NetworkImage("${GlobalVariable.myplanetUrl}/${thumbnail ?? ""}"),
                        width: 140,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                          overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
                          maxLines: 1, // Limit the text to a single line
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SizedBox(
                    width: 135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          subTitle ?? "",
                          style: TextStyle(
                            fontSize: 10,
                            color: secondaryColor,
                            fontWeight: medium,
                            fontFamily: 'Poppins', // Set the font family to Poppins
                          ),
                        ),
                        Visibility(visible: rating == null ? false : true , child: const Icon(Icons.star, color: Color(0xffFFCE31), size: 12,)),
                        Text(
                          rating.toString() == 'null' ? "" : rating.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: secondaryColor,
                            fontWeight: medium,
                            fontFamily: 'Poppins', // Set the font family to Poppins
                          ),
                        ),
                        Text(
                          ratingCount.toString() == 'null' ? "" : ' (${ratingCount.toString()})',
                          style: TextStyle(
                            fontSize: 10,
                            color: secondaryColor,
                            fontWeight: medium,
                            fontFamily: 'Poppins', // Set the font family to Poppins
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SizedBox(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}