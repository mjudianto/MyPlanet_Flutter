import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myplanet/theme.dart';

class ImageSliderWithIndicator extends StatefulWidget {
  final List<String> imageAssetNames; // Daftar nama file gambar

  ImageSliderWithIndicator(this.imageAssetNames);

  @override
  _ImageSliderWithIndicatorState createState() =>
      _ImageSliderWithIndicatorState();
}

class _ImageSliderWithIndicatorState extends State<ImageSliderWithIndicator> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: 2.0,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.imageAssetNames
              .map((assetName) => Container(
                    child: Container(
                      // margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              assetName, // Gunakan Image.asset untuk gambar
                              fit: BoxFit.cover,
                              width: 1000.0,
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageAssetNames.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _current == entry.key ? 24.0 : 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: _current == entry.key
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius: _current == entry.key
                      ? BorderRadius.circular(
                          5.0) // Atur radius sesuai preferensi Anda
                      : null,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? secondaryColor
                          : primaryColor)
                      .withOpacity(
                    _current == entry.key ? 0.9 : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
