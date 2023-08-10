import 'package:flutter/material.dart';
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
  });

  final String? thumbnail;
  final String? title;
  final String? subTitle;
  final String? subTitle2;
  final double? rating;
  final int? ratingCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185,
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
                      image: NetworkImage("https://myplanet.enseval.com/${thumbnail ?? ""}"),
                      width: 157,
                      height: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 132,
                      child: Text(
                        title ?? "",
                        style: TextStyle(
                          fontSize: 15,
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
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      subTitle ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: medium,
                        fontFamily: 'Poppins', // Set the font family to Poppins
                      ),
                    ),
                    Visibility(visible: rating == null ? false : true , child: const Icon(Icons.star, color: Color(0xffFFCE31), size: 16,)),
                    Text(
                      rating.toString() == 'null' ? "" : rating.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: medium,
                        fontFamily: 'Poppins', // Set the font family to Poppins
                      ),
                    ),
                    Text(
                      ratingCount.toString() == 'null' ? "" : ' (${ratingCount.toString()})',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: medium,
                        fontFamily: 'Poppins', // Set the font family to Poppins
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.draw_outlined,
                      size: 15,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        subTitle2 ?? "Learning & People Development",
                        style: TextStyle(
                          fontSize: 12,
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
    );
  }
}