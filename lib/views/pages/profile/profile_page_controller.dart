
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/providers/users/user_provider.dart';

class ProfilePageController extends GetxController {

  // change password 
  bool passwordChangedSuccessfully = false;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  
  RxBool isOldPasswordHidden = true.obs;
  RxBool isNewPasswordHidden = true.obs;
  RxBool isConfirmNewPasswordHidden = true.obs;

  void changePassword (String oldPassword, String newPassword) async {
    String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
    try {
      UserProvider.changeUserPassword(userToken, oldPassword, newPassword);
      passwordChangedSuccessfully = true;
    } catch (e) {
      passwordChangedSuccessfully = false;
    }
  }
}