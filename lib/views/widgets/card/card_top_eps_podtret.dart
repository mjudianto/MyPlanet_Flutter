import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';
import 'package:get/get.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';

class CardTopEps extends StatelessWidget {
  final dynamic item;

  const CardTopEps({super.key, required this.item});

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
          width: 300,
          margin: const EdgeInsets.only(
            right: 38,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    'assets/loading.jpeg', // Placeholder image
                    width: 122,
                    height: 69,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/podtret_placeholder.jpeg', // Default image for errors
                    width: 122,
                    height: 69,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: '${GlobalVariable.myplanetUrl}/${item.thumbnail}',
                  width: 122,
                  height: 69,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10), // Jarak antara thumbnail dan teks
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            100), // Mengatur border radius
                        color: primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          item.nama,
                          style: blackTextStyle.copyWith(
                            fontSize: 8,
                            fontWeight: medium,
                            color:
                                whiteColor, // Ganti warna teks sesuai kebutuhan
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.judul,
                      style: blackTextStyle.copyWith(
                        fontSize: 11,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.views}x • $publishDate',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 8,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
