import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        margin: const EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, top: 60),
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
                primary: primaryColor,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(100), // Radius yang diinginkan.
                ),
              ),
              onPressed: () {
                print('download!');
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: const PageAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const PageAppBar(
                type: 'text',
                title: 'Certificate',
              ),
              content()
            ],
          ),
        ),
      ),
    );
  }
}
