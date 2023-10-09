import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/profile/account_info.dart';
import 'package:myplanet/views/pages/profile/certificate.dart';
import 'package:myplanet/views/pages/profile/test_history.dart';
import 'package:myplanet/views/pages/profile/training_history.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AccountInfo(), // Ganti dengan nama yang sesuai
                        ),
                      );
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
                  const Divider(),
                  const SizedBox(
                    height: 14,
                  ),
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
                              'assets/icons/ic_key.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Change Password',
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
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors
                    .white, // Ganti dengan warna background yang diinginkan
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TrainingHistory(), // Ganti dengan nama yang sesuai
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_history.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Training History',
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
                  const Divider(),
                  const SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TestHistory(), // Ganti dengan nama yang sesuai
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_training_history.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Test History',
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
                  const Divider(),
                  const SizedBox(
                    height: 14,
                  ),
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
                              'assets/icons/ic_book.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Mandatory',
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
                  const Divider(),
                  const SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Certificate(), // Ganti dengan nama yang sesuai
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_certificate.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Training Certificate',
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
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height: 270,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              50), // Atur border radius sudut kiri atas
                          topRight: Radius.circular(
                              50), // Atur border radius sudut kanan atas
                        ),
                      ),
                      // color: whiteColor,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Keluar',
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text('Apakah anda yakin ingin keluar?'),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: defaultMargin,
                                    ),
                                    height: 54,
                                    child: TextButton(
                                      onPressed: () {
                                        print('DUAR');
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: dangerColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Keluar',
                                            style: whiteTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: defaultMargin,
                                    ),
                                    height: 54,
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        backgroundColor: secondaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Kembali',
                                            style: whiteTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.transparent,
                primary: Colors
                    .transparent, // Atur warna background menjadi transparan
              ),
              child: Container(
                padding:
                    const EdgeInsets.all(16), // Atur padding sesuai kebutuhan
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      20), // Atur border radius sesuai kebutuhan
                  color: whiteColor, // Atur warna background sesuai kebutuhan
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_logout.svg',
                          width: 24,
                        ),
                        const SizedBox(width: 14),
                        const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors
                                .black, // Ganti dengan warna teks yang diinginkan
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors
                          .black, // Ganti dengan warna ikon yang diinginkan
                    ),
                  ],
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
