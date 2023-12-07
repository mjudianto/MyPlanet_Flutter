import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_controller.dart';
import 'package:myplanet/views/pages/login_page.dart';
import 'package:myplanet/views/pages/profile/profile_page_controller.dart';
import 'package:myplanet/views/pages/profile/certificate.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  ProfilePageController profilePageController = Get.find();

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
                    alignment: Alignment.bottomRight, // Menempatkan ikon kamera di bawah kanan
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
                          imageUrl: '${GlobalVariable.myplanetUrl}/userAssets/Foto_emos/${GlobalVariable.userData['user']['empnik']}.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6), // Atur padding sesuai kebutuhan
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
        margin: const EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: defaultMargin),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Ganti dengan warna background yang diinginkan
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.accountInfo);
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
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            height: 500,
                            decoration: const BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50), // Atur border radius sudut kiri atas
                                topRight: Radius.circular(50), // Atur border radius sudut kanan atas
                              ),
                            ),
                            // color: whiteColor,
                            child: Center(
                              child: SizedBox(
                                width: Get.width * 0.9,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              'Ganti Kata Sandi',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 18,
                                                fontWeight: semiBold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Obx(() {
                                      return InputWithTitle(
                                        title: 'Kata Sandi Lama',
                                        controller: profilePageController.oldPasswordController,
                                        hintText: 'Kata Sandi Lama',
                                        obscureText: profilePageController.isOldPasswordHidden.value,
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              profilePageController.isOldPasswordHidden.value ? Icons.visibility_off : Icons.visibility_outlined,
                                              color: primaryColor,
                                            ),
                                            onPressed: () {
                                              if (profilePageController.isOldPasswordHidden.value) {
                                                profilePageController.isOldPasswordHidden.value = false;
                                              } else {
                                                profilePageController.isOldPasswordHidden.value = true;
                                              }
                                            }),
                                      );
                                    }),
                                    const SizedBox(height: 20),
                                    Obx(() {
                                      return InputWithTitle(
                                        title: 'Kata Sandi Baru',
                                        controller: profilePageController.newPasswordController,
                                        hintText: 'Kata Sandi Baru',
                                        obscureText: profilePageController.isNewPasswordHidden.value,
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              profilePageController.isNewPasswordHidden.value ? Icons.visibility_off : Icons.visibility_outlined,
                                              color: primaryColor,
                                            ),
                                            onPressed: () {
                                              if (profilePageController.isNewPasswordHidden.value) {
                                                profilePageController.isNewPasswordHidden.value = false;
                                              } else {
                                                profilePageController.isNewPasswordHidden.value = true;
                                              }
                                            }),
                                      );
                                    }),
                                    const SizedBox(height: 20),
                                    Obx(() {
                                      return InputWithTitle(
                                        title: 'Konfirmasi Sandi Baru',
                                        controller: profilePageController.confirmNewPasswordController,
                                        hintText: 'Konfirmasi Sandi Baru',
                                        obscureText: profilePageController.isConfirmNewPasswordHidden.value,
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              profilePageController.isConfirmNewPasswordHidden.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility_outlined,
                                              color: primaryColor,
                                            ),
                                            onPressed: () {
                                              if (profilePageController.isConfirmNewPasswordHidden.value) {
                                                profilePageController.isConfirmNewPasswordHidden.value = false;
                                              } else {
                                                profilePageController.isConfirmNewPasswordHidden.value = true;
                                              }
                                            }),
                                      );
                                    }),
                                    const SizedBox(
                                      height: 35,
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
                                                if (profilePageController.newPasswordController.text ==
                                                    profilePageController.confirmNewPasswordController.text) {
                                                  profilePageController.changePassword(profilePageController.oldPasswordController.text,
                                                      profilePageController.newPasswordController.text);
                                                  Get.back();

                                                  Get.defaultDialog(
                                                    title: profilePageController.passwordChangedSuccessfully ? 'SUCCESS' : 'FAILED',
                                                    titlePadding: const EdgeInsets.all(20.0),
                                                    middleText: profilePageController.passwordChangedSuccessfully
                                                        ? 'Password change SUCCESS'
                                                        : 'Password change FAILED',
                                                  );
                                                } else {
                                                  Get.defaultDialog(
                                                    title: 'FAILED',
                                                    titlePadding: const EdgeInsets.all(20.0),
                                                    middleText: 'konfirmasi sandi baru tidak cocok',
                                                  );
                                                }
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(100),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Submit',
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
                            ),
                          );
                        },
                      );
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
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                color: Colors.white, // Ganti dengan warna background yang diinginkan
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.trainingHistoryPage);
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
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                      Get.toNamed(RouteName.testHistoryPage);
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
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                      Get.toNamed(RouteName.mandatoryPage);
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
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                          builder: (context) => const Certificate(), // Ganti dengan nama yang sesuai
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
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                color: Colors.white, // Ganti dengan warna background yang diinginkan
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Privacy and Policy");
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
                              'Privacy Policy',
                              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
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
                                topLeft: Radius.circular(50), // Atur border radius sudut kiri atas
                                topRight: Radius.circular(50), // Atur border radius sudut kanan atas
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
                                            onPressed: () async {
                                              await GlobalVariable.secureStorage.delete(key: 'user_token');
                                              DashboardController dashboardController = Get.find();
                                              dashboardController.tabIndex = 0;

                                              Get.offAllNamed('/login');
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: dangerColor,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                      backgroundColor: Colors.transparent, // Atur warna background menjadi transparan
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
                                color: Colors.black, // Ganti dengan warna teks yang diinginkan
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.black, // Ganti dengan warna ikon yang diinginkan
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
            // ElevatedButton(
            //   onPressed: () {
            //     showModalBottomSheet<void>(
            //       context: context,
            //       backgroundColor: Colors.transparent,
            //       builder: (BuildContext context) {
            //         return Container(
            //           height: 270,
            //           decoration: const BoxDecoration(
            //             color: whiteColor,
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(50), // Atur border radius sudut kiri atas
            //               topRight: Radius.circular(50), // Atur border radius sudut kanan atas
            //             ),
            //           ),
            //           // color: whiteColor,
            //           child: Center(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               mainAxisSize: MainAxisSize.min,
            //               children: <Widget>[
            //                 Text(
            //                   'Keluar',
            //                   style: blackTextStyle.copyWith(
            //                     fontSize: 18,
            //                     fontWeight: semiBold,
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   height: 24,
            //                 ),
            //                 const Text('Apakah anda yakin ingin keluar?'),
            //                 const SizedBox(
            //                   height: 24,
            //                 ),
            //                 SizedBox(
            //                   child: Column(
            //                     children: [
            //                       Container(
            //                         margin: const EdgeInsets.symmetric(
            //                           horizontal: defaultMargin,
            //                         ),
            //                         height: 54,
            //                         child: TextButton(
            //                           onPressed: () async {
            //                             await GlobalVariable.secureStorage.delete(key: 'user_token');
            //                             DashboardController dashboardController = Get.find();
            //                             dashboardController.tabIndex = 0;

            //                             Get.offAllNamed('/login');
            //                           },
            //                           style: TextButton.styleFrom(
            //                             backgroundColor: dangerColor,
            //                             padding: const EdgeInsets.symmetric(
            //                               horizontal: 20,
            //                             ),
            //                             shape: RoundedRectangleBorder(
            //                               borderRadius: BorderRadius.circular(100),
            //                             ),
            //                           ),
            //                           child: Row(
            //                             mainAxisAlignment: MainAxisAlignment.center,
            //                             children: [
            //                               Text(
            //                                 'Keluar',
            //                                 style: whiteTextStyle.copyWith(
            //                                   fontSize: 16,
            //                                   fontWeight: semiBold,
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   height: 8,
            //                 ),
            //                 SizedBox(
            //                   child: Column(
            //                     children: [
            //                       Container(
            //                         margin: const EdgeInsets.symmetric(
            //                           horizontal: defaultMargin,
            //                         ),
            //                         height: 54,
            //                         child: TextButton(
            //                           onPressed: () => Navigator.pop(context),
            //                           style: TextButton.styleFrom(
            //                             backgroundColor: secondaryColor,
            //                             padding: const EdgeInsets.symmetric(
            //                               horizontal: 20,
            //                             ),
            //                             shape: RoundedRectangleBorder(
            //                               borderRadius: BorderRadius.circular(100),
            //                             ),
            //                           ),
            //                           child: Row(
            //                             mainAxisAlignment: MainAxisAlignment.center,
            //                             children: [
            //                               Text(
            //                                 'Kembali',
            //                                 style: whiteTextStyle.copyWith(
            //                                   fontSize: 16,
            //                                   fontWeight: semiBold,
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.zero,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     shadowColor: Colors.transparent,
            //     backgroundColor: Colors.transparent, // Atur warna background menjadi transparan
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 16.0),
            //     child: Container(
            //       padding: const EdgeInsets.all(16), // Atur padding sesuai kebutuhan
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20), // Atur border radius sesuai kebutuhan
            //         color: whiteColor, // Atur warna background sesuai kebutuhan
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               SvgPicture.asset(
            //                 'assets/icons/ic_logout.svg',
            //                 width: 24,
            //               ),
            //               const SizedBox(width: 14),
            //               const Text(
            //                 'Logout',
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.w600,
            //                   color: Colors.black, // Ganti dengan warna teks yang diinginkan
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const Icon(
            //             Icons.chevron_right,
            //             color: Colors.black, // Ganti dengan warna ikon yang diinginkan
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: PageAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PageAppBar(
              type: 'text',
              title: 'Profle',
            ),
            header(),
            content()
          ],
        ),
      ),
    );
  }
}
