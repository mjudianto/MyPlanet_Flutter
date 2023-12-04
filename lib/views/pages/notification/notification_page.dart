import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:popup_banner/popup_banner.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> images = [
    "https://tinyurl.com/popup-banner-image",
    "https://tinyurl.com/popup-banner-image2",
    "https://tinyurl.com/popup-banner-image3",
    "https://tinyurl.com/popup-banner-image4"
  ];

  List<String> imagesLocal = [
    "assets/myplanet_ison.png",
    "assets/thankyou.png",
    "assets/myplanet_ison.png",
  ];

  void showDefaultPopup(BuildContext context) {
    PopupBanner(
      context: context,
      images: images,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showHideDotsPopup(BuildContext context) {
    PopupBanner(
      context: context,
      images: images,
      useDots: false,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  void showCustomizeDots(BuildContext context) {
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

  void showNonactiveSlideCustomClose(BuildContext context) {
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

  void showFromLocal(BuildContext context) {
    PopupBanner(
      context: context,
      images: imagesLocal,
      fromNetwork: false,
      onClick: (index) {},
    ).show();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: PageAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageAppBar(
                type: 'text',
                title: 'Notification',
              ),
              // content()
              // const UnderConstruction(),
              // const Popup()
              ElevatedButton(
                onPressed: () => showFromLocal(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Show Default Popup",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
