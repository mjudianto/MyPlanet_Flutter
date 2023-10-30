import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myplanet/theme.dart';

class BtnMore extends StatelessWidget {
  const BtnMore({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: 86,
              decoration: const BoxDecoration(
                color: whiteColor,
              ),
              // color: whiteColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: TextButton(
                              onPressed: () {
                                // print('Terlapor!');
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: whiteColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/community/ic_flag.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Laporkan post',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                              onPressed: () {
                                // print('Terlapor!');
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: whiteColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/ic_trash.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Hapus',
                                    style: blackTextStyle.copyWith(
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
                  ],
                ),
              ),
            );
          },
        );
      },
      child: SvgPicture.asset(
        'assets/icons/ic_more.svg',
        width: 18,
      ),
    );
  }
}
