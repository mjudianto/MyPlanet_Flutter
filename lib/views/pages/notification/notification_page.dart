import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Container(
        margin: const EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, top: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // print("Notif Check");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Atur posisi child ke start (kiri)
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/icons/ic_notif_podtret.png',
                          width: 54,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'PODTRET',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Video terbaru telah dirilis! Tonton “Eps 54 : Disenyumin Noni Belanda” sekarang. Klik pemberitahuan ini untuk menonton.',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular, // Membuat teks ini bold.
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          Text(
                            '2m',
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          InkWell(
                            onTap: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Hapus',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          const Text(
                                              'Apakah anda yakin ingin menghapus notifikasi ini?'),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          SizedBox(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: defaultMargin,
                                                  ),
                                                  height: 54,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // print('WKWK!');
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          dangerColor,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Hapus',
                                                          style: whiteTextStyle
                                                              .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                semiBold,
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
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: defaultMargin,
                                                  ),
                                                  height: 54,
                                                  child: TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          secondaryColor,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Kembali',
                                                          style: whiteTextStyle
                                                              .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                semiBold,
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
                            child: SvgPicture.asset(
                              'assets/icons/ic_more.svg',
                              width: 15,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 2,
                    color: blackColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Tambahkan aksi yang diinginkan ketika diklik di sini.
                // print('Klik pada elemen Column');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Atur posisi child ke start (kiri)
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/icons/ic_notif_elearning.png',
                          width: 54,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'PODTRET',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Video terbaru telah dirilis! Tonton “Eps 54 : Disenyumin Noni Belanda” sekarang. Klik pemberitahuan ini untuk menonton.',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular, // Membuat teks ini bold.
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          Text(
                            '2m',
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          InkWell(
                            onTap: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Hapus',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          const Text(
                                              'Apakah anda yakin ingin menghapus notifikasi ini?'),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          SizedBox(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: defaultMargin,
                                                  ),
                                                  height: 54,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // print('WKWK!');
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          dangerColor,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Hapus',
                                                          style: whiteTextStyle
                                                              .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                semiBold,
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
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: defaultMargin,
                                                  ),
                                                  height: 54,
                                                  child: TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          secondaryColor,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Kembali',
                                                          style: whiteTextStyle
                                                              .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                semiBold,
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
                            child: SvgPicture.asset(
                              'assets/icons/ic_more.svg',
                              width: 15,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 2,
                    color: blackColor,
                  ),
                  const SizedBox(
                    height: 16,
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
              content()
            ],
          ),
        ),
      ),
    );
  }
}
