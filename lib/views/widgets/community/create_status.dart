import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myplanet/theme.dart';

class CreateStatus extends StatelessWidget {
  const CreateStatus({super.key});

  @override
  Widget build(BuildContext context) {
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
}
