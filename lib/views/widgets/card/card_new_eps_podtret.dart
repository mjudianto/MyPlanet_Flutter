import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/new_eps_podtret.dart';
import 'package:get/get.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';

class CardNewEps extends StatelessWidget {
  final dynamic item;

  const CardNewEps({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(item.publishDate.toString());
    String publishDate = DateFormat('dd MMMM yyyy').format(dateTime);
    PodtretKontenController podtretKontenController = Get.find();

    return GestureDetector(
      onTap: () {
        podtretKontenController.podtret = item;

        Get.toNamed(RouteName.podtretContent);
      },
      child: Container(
          width: 136,
          // height: 278,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    'assets/loading.jpeg', // Placeholder image
                    width: 136,
                    height: 77,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/podtret_placeholder.jpeg', // Default image for errors
                    width: 136,
                    height: 77,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: '${GlobalVariable.myplanetUrl}/${item.thumbnail}',
                  width: 136,
                  height: 77,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  item.judul,
                  style: blackTextStyle.copyWith(
                      fontSize: 11, fontWeight: semiBold),
                  overflow: TextOverflow
                      .ellipsis, // klo tulisannya panjang jadi titik titik
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '${item.views}x watched • $publishDate',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 8,
                    fontWeight: regular,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // klo tulisannya panjang jadi titik titik
                  maxLines: 1, // maksimal tulisan 1 baris
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  item.nama,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 8,
                    fontWeight: regular,
                  ),
                ),
              ])
            ],
          )),
    );
  }
}
