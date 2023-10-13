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
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Atur posisi child ke start (kiri)
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
                            print('test');
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
