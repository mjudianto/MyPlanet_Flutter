import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';
import 'package:myplanet/views/widgets/carousel/carouselPodtret/carousel_podtret_controller.dart';

class ImageSliderWithIndicator extends StatelessWidget {
  final List<dynamic> podtretList; // Daftar nama file gambar
  final ImageSliderController controller = Get.find();

  ImageSliderWithIndicator(this.podtretList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.currentIndex.value = 0;

    return Column(
      children: [
        CarouselSlider(
          carouselController: controller.carouselController,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: 2.0,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              controller.onPageChanged(index); // Update the currentIndex here
            },
          ),
          items: podtretList
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
                  onTap: () {
                    PodtretKontenController podtretKontenController = Get.find();

                    podtretKontenController.podtret = entry.value;

                    Get.toNamed(RouteName.podtretContent);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.jpeg'),
                      image: NetworkImage('${GlobalVariable.myplanetUrl}/${entry.value.thumbnail}'),
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(() => _buildIndicators(context)),
      ],
    );
  }

  Widget _buildIndicators(BuildContext context) {
    int current = controller.currentIndex.value;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: podtretList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => controller.carouselController.animateToPage(entry.key),
          child: Container(
            width: current == entry.key ? 24.0 : 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
            decoration: BoxDecoration(
              shape: current == entry.key ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: current == entry.key ? BorderRadius.circular(5.0) : null,
              color: (Theme.of(context).brightness == Brightness.dark ? secondaryColor : primaryColor).withOpacity(
                current == entry.key ? 0.9 : 0.4,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
