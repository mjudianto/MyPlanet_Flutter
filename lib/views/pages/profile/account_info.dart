import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

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
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            'assets/loading.jpeg', // Placeholder image
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/icons/avatar.png', // Default image for errors
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                          imageUrl: '${GlobalVariable.myplanetUrl}/${GlobalVariable.userData['user']['empnik']}',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
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
                  GlobalVariable.userData['user']['EmpName'],
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
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_user.svg',
                  width: 24,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    ),
                    Text(
                      GlobalVariable.userData['user']['EmpName'],
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    const Divider(
                      height: 2,
                      color: blackColor,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              color: blackColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_nik.svg',
                  width: 24,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NIK',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    ),
                    Text(
                      GlobalVariable.userData['user']['empnik'],
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    const Divider(
                      height: 2,
                      color: blackColor,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              color: blackColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_telp.svg',
                  width: 24,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    ),
                    Text(
                      GlobalVariable.userData['user']['PhoneNumberEmployee'],
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    const Divider(
                      height: 2,
                      color: blackColor,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              color: blackColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_mail.svg',
                  width: 24,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mail',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    ),
                    Text(
                      GlobalVariable.userData['user']['EmailEmployee'],
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    const Divider(
                      height: 2,
                      color: blackColor,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              color: blackColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_organization.svg',
                  width: 24,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Organization',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    ),
                    Text(
                      GlobalVariable.userData['user']['orgname'],
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    const Divider(
                      height: 2,
                      color: blackColor,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              color: blackColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_company.svg',
                  width: 24,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: regular),
                    ),
                    Text(
                      GlobalVariable.userData['user']['LocationName'],
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    const Divider(
                      height: 2,
                      color: blackColor,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: const PageAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const PageAppBar(
              type: 'text',
              title: 'Account Info',
            ),
            header(),
            content()
          ],
        ),
      ),
    );
  }
}
