import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/controllers/campaign_controllet.dart';
import 'package:myplanet/controllers/users/user_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/users/user_model.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/login_appbar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  final RxBool _loginButtonClicked = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const LoginAppBar(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: semiBold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Masuk untuk melanjutkan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: regular,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputWithTitle(
                        title: 'NIK',
                        controller: _nikController,
                        hintText: 'Masukkan NIK',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      InputWithTitle(
                          title: 'Kata Sandi',
                          controller: _passwordController,
                          hintText: 'Masukkan Kata Sandi',
                          obscureText: _isPasswordVisible,
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              })),
                      const SizedBox(height: 50),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: () async {
                                _loginButtonClicked.value = true;
                                // Fetch the user token when the button is pressed
                                try {
                                  User userToken = await UserController.fetchUserToken(_nikController.text, _passwordController.text)
                                      .timeout(const Duration(seconds: 10));

                                  await GlobalVariable.secureStorage.write(key: 'user_token', value: userToken.data);

                                  GlobalVariable.userData = JwtDecoder.decode(userToken.data!);

                                  GlobalVariable.campaigns = await CampaignController.fetchActiveCampaign();

                                  // ignore: use_build_context_synchronously
                                  Get.offNamed(RouteName.dashboardPage);
                                } catch (e) {
                                  print(e);
                                  _loginButtonClicked.value = false;

                                  return showTopSnackBar(
                                    // ignore: use_build_context_synchronously
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: e.toString(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _loginButtonClicked.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: whiteColor,
                                      ))
                                  : Text(
                                      'Masuk',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: Get.height * 0.2,),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                color: whiteColor,
                                child: Center(
                                  child: ListView(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Lupa Sandi',
                                                style: blackTextStyle.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: medium,
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
                                        height: 40,
                                      ),
                                      Text(
                                        'Silahkan masukan NIK anda untuk mereset kata sandi. Lalu periksa email anda secara berkala',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InputWithTitle(
                                        title: 'NIK',
                                        controller: _nikController,
                                        hintText: 'Masukkan NIK',
                                        icon: Icons.person,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              await UserController.forgotPassword(_nikController.text);

                                              Get.back();

                                              return showTopSnackBar(
                                                // ignore: use_build_context_synchronously
                                                Overlay.of(context),
                                                const CustomSnackBar.success(
                                                  message: "Kata sandi baru telah dikirim ke email anda",
                                                ),
                                              );
                                            } catch (e) {
                                              return showTopSnackBar(
                                                // ignore: use_build_context_synchronously
                                                Overlay.of(context),
                                                const CustomSnackBar.error(
                                                  message: "NIK tidak ditemukan",
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Lupa kata sandi? Disini',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputWithTitle extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final Widget? suffixIcon;

  const InputWithTitle({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.icon,
    this.suffixIcon,
  });

  @override
  State<InputWithTitle> createState() => _InputWithTitleState();
}

class _InputWithTitleState extends State<InputWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: medium,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: widget.icon == null ? 0 : 15.0, right: widget.icon == null ? 0 : 10.0),
                child: Icon(
                  widget.icon, // Change this to the desired icon
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60, // Adjust the width
                height: 50,
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blackColor,
                    fontWeight: medium,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: secondaryColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: widget.icon == null ? 20 : 15.0),
                child: widget.suffixIcon,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
