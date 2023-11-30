import 'package:flutter/material.dart';
import 'package:popup_banner/popup_banner.dart';

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  List<String> images = [
    "https://tinyurl.com/popup-banner-image",
    "https://tinyurl.com/popup-banner-image2",
    "https://tinyurl.com/popup-banner-image3",
    "https://tinyurl.com/popup-banner-image4"
  ];

  List<String> imagesLocal = [
    "assets/images/popup-banner-local-image.jpg",
    "assets/images/popup-banner-local-image2.jpg",
    "assets/images/popup-banner-local-image3.jpeg",
    "assets/images/popup-banner-local-image4.jpg"
  ];

  void showDefaultPopup() {
    PopupBanner(
      context: context,
      images: images,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showHideDotsPopup() {
    PopupBanner(
      context: context,
      images: images,
      useDots: false,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showCustomizeDots() {
    PopupBanner(
      context: context,
      images: images,
      dotsAlignment: Alignment.bottomCenter,
      dotsColorActive: Colors.blue,
      dotsColorInactive: Colors.grey.withOpacity(0.5),
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showNonactiveSlideCustomClose() {
    PopupBanner(
      context: context,
      images: images,
      autoSlide: false,
      customCloseButton: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        child: const Text(
          "Close",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showFromLocal() {
    PopupBanner(
      context: context,
      images: imagesLocal,
      fromNetwork: false,
      onClick: (index) {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buttonWidget(
              title: "Default Popup",
              onClick: () => showDefaultPopup(),
            ),
            _buttonWidget(
              title: "Hide Dots Popup",
              onClick: () => showHideDotsPopup(),
            ),
            _buttonWidget(
              title: "Customize Dots Popup",
              onClick: () => showCustomizeDots(),
            ),
            _buttonWidget(
              title: "Disable Auto Slide & Custom Close Popup",
              onClick: () => showNonactiveSlideCustomClose(),
            ),
            _buttonWidget(
              title: "Local Asset Popup",
              onClick: () => showFromLocal(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonWidget({
    required String title,
    required VoidCallback onClick,
  }) {
    return ElevatedButton(
      onPressed: () => onClick(),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
