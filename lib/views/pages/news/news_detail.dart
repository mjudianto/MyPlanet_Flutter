import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/banner_news.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: AppBar(
              leading: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/btn_back_round.svg',
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context); // Fungsi untuk kembali ke halaman sebelumnya
                  },
                ),
              ),
              title: const SizedBox(
                height: 221,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      'News',
                    ),
                  ],
                ),
              ),
              toolbarHeight: 221,
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
          ));
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '10 Kota dengan Kualitas Udara Terbersih di Indonesia, Pas Buat Tempat Healing dari Polusi',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'People and Learning Development',
              style: blackTextStyle.copyWith(
                fontSize: 10,
                fontWeight: regular,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Kamis, 31 Agustus 2023 10:31 WIB',
              style: blackTextStyle.copyWith(
                fontSize: 10,
                fontWeight: regular,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'DKI Jakarta sejak beberapa minggu terakhir menjadi kota yang memiliki kualitas udara terburuk di dunia. Bagaimana tidak, menurut data kualitas udara yang dilansir dari situs IQAir, diketahui bahwa kualitas udara di Jakarta sampai menyentuh poin hingga 3 digit. Alhasil, kualitas udara masuk kategori tidak sehat.',
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Berbagai upaya pun dilakukan pemerintah demi mengurangi populasi. Mulai dari penerapan WFH untuk ASN hingga penerapan hujan buatan. Sayangnya, usaha ini tidak banyak membantu karena per akhir Agustus 2023, kualitas udara di Jakarta masih dalam kategori tidak sehat.',
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: const PageAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [header(), content()],
          ),
        ),
      ),
    );
  }
}
