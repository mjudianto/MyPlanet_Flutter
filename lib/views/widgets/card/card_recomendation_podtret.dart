import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_page.dart';

class CardRecomendation extends StatelessWidget {
  final dynamic item;

  const CardRecomendation({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    PodtretKontenController podtretKontenController = Get.find();
    return GestureDetector(
      onTap: () {
        podtretKontenController.podtret = item;

        Get.toNamed(RouteName.podtretContent);
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
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      'assets/loading.jpeg', // Placeholder image
                      width: 282,
                      height: 157,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/podtret_placeholder.jpeg', // Default image for errors
                      width: 282,
                      height: 157,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: '${GlobalVariable.myplanetUrl}/${item.thumbnail}',
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
                                item.judul,
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
                                item.nama,
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
