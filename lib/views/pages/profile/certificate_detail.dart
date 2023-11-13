import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';

class CertificateDetail extends StatefulWidget {
  const CertificateDetail({super.key});

  @override
  State<CertificateDetail> createState() => _CertificateDetailState();
}

class _CertificateDetailState extends State<CertificateDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Container(
        margin: const EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'e-certificate',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Enseval Bootcamp',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Terima Kasih telah menyelesaikan e-learning ',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  TextSpan(
                    text: 'Enseval Bootcamp',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: bold, // Membuat teks ini bold.
                    ),
                  ),
                  TextSpan(
                    text: ' dengan baik',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Image.asset('assets/certificate.jpg'),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100), // Radius yang diinginkan.
                ),
              ),
              onPressed: () {
                // print('download!');
              },
              child: Text(
                'Download',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget title() {
      return Container(
        margin: const EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: defaultMargin),
        child: Column(
          children: [
            Text(
              'e-certificate',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Enseval Bootcamp',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Terima Kasih telah menyelesaikan e-learning ',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  TextSpan(
                    text: 'Enseval Bootcamp',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: bold, // Membuat teks ini bold.
                    ),
                  ),
                  TextSpan(
                    text: ' dengan baik',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget certificate() {
      return Container(
        width: double.infinity,
        height: 260,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.only(top: 75),
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/certificate_raw.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nanda Raditya',
              style: certificateTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'NIK : ',
                    style: certificateTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: semiBold,
                    ),
                  ),
                  TextSpan(
                    text: '230100022',
                    style: certificateTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: medium, // Membuat teks ini bold.
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Text(
              'Enseval Bootcamp',
              style: certificateTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '3 Agustus 2023',
              style: certificateTextStyle.copyWith(
                fontSize: 8,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    Widget btnDownload() {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Radius yang diinginkan.
            ),
          ),
          onPressed: () {
            // print('download!');
          },
          child: Text(
            'Download',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

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
                title: 'Certificate',
              ),
              // content()
              title(),
              certificate(),
              btnDownload()
            ],
          ),
        ),
      ),
    );
  }
}
