import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplanet/controllers/users/user_controller.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/users/user_model.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/appBar/login_appbar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';  

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: const HomePageAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const LoginAppBar(),

              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
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
                    const SizedBox(height: 5,),
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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
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
                          }
                        )
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Fetch the user token when the button is pressed
                            try {
                              User userToken = await UserController.fetchUserToken(_nikController.text, _passwordController.text);

                              await GlobalVariable.secureStorage.write(key: 'user_token', value: userToken.data);

                              GlobalVariable.userData = JwtDecoder.decode(userToken.data!);

                              // ignore: use_build_context_synchronously
                              context.go('/home');
                            
                            } catch (e) {
                              // Handle exceptions that might occur during the authentication process
                              // print('Error during authentication: $e');
                              // Display an error message or take appropriate actions
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Masuk',
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
              const SizedBox(height: 192,),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle the "Lupa kata sandi?" action here
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
                padding: const EdgeInsets.only(left: 15.0, right: 10.0),
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
                padding: const EdgeInsets.only(left: 15.0),
                child: widget.suffixIcon,
              ),
             
            ],
          ),
        ),
      ],
    );
  }
}

