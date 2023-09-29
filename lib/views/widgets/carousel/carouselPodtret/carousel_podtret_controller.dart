import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class ImageSliderController extends GetxController {
  RxInt currentIndex = 0.obs;
  final CarouselController carouselController = CarouselController();

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
