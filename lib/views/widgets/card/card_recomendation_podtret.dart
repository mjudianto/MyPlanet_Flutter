import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/video_play_podtret.dart';

class CardRecomendation extends StatelessWidget {
  const CardRecomendation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VideoPlayPodtret(), // Ganti dengan nama yang sesuai
          ),
        );
      },
      child: SizedBox(
        width: 283,
        height: 250,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(right: 12),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/podtret/thumbnail/eps74.png',
                    width: 282,
                    height: 157,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      100), // Mengatur border radius
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      yellowColor,
                                      whiteColor
                                    ], // Ganti warna sesuai kebutuhan
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                    'Rekomendasi',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 8,
                                      fontWeight: medium,
                                      color:
                                          blackColor, // Ganti warna teks sesuai kebutuhan
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Eps 74 : Tips Biar Gaji Gak Boncos !!',
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: semiBold,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // klo tulisannya panjang jadi titik titik
                                maxLines: 1, // maksimal tulisan 1 baris
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Kumis',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: regular,
                                ),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/ic_play_podtret.svg',
                          width: 26,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
