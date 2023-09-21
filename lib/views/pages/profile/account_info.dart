import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            SizedBox(
                child: Center(
                    child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    // Tambahkan kode untuk mengganti foto profil di sini
                  },
                  child: Stack(
                    alignment: Alignment
                        .bottomRight, // Menempatkan ikon kamera di bawah kanan
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/nanda.jpg',
                          width: 90,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                            6), // Atur padding sesuai kebutuhan
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: whiteColor, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: whiteColor, // Ganti warna sesuai kebutuhan
                            size: 16 // Sesuaikan ukuran sesuai kebutuhan
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'Nanda Raditya',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                )
              ],
            ))),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, top: defaultMargin),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors
                    .white, // Ganti dengan warna background yang diinginkan
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('meledak dUaaaAArrrRR!!!');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_user.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Account Info',
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: blackColor,
                        ),
                      ],
                    ),
                  ),
                ],
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
                title: 'Profle',
              ),
              header(),
              content()
            ],
          ),
        ),
      ),
    );
  }
}
