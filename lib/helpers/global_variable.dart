import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';  

class GlobalVariable {

  static String currentUrl = '';
  static String apiUrl = 'https://myplanet.enseval.com:3000';
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Map<String, dynamic> userData = {};


  static Future<bool> userAuth() async {
    String? storedToken = await GlobalVariable.secureStorage.read(key: 'user_token');

    if (storedToken == null) {
      return false;
    }

    bool tokenExpired = JwtDecoder.isExpired(storedToken);

    GlobalVariable.userData = JwtDecoder.decode(storedToken);
    
    // bool isLoggedIn = storedToken != null;
    return !tokenExpired;
  }

  static Future<bool> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {  
      return true;
    } else {
      return false;
    }
  }    
  
}