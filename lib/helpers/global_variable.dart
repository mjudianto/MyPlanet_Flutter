import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class GlobalVariable {
  static String currentUrl = '';
  // static String apiUrl = 'https://myplanet.enseval.com:3000';
  static String apiUrl = 'https://myplanet-apiapps.enseval.com/';
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Map<String, dynamic> userData = {};
  static String myplanetUrl = 'https://myplanet.enseval.com';

  static dynamic elearningSearchData;
  static dynamic podtretSearchData;
  static dynamic combinedElearningPodtretSearchData;

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

    final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/testConnection'));

    if (result == true && response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static setElearningSearchBarData(dynamic data) {
    if (data != null) {
      elearningSearchData = data;
    }
  }

  static setPodtretSearchBarData(dynamic data) {
    if (data != null) {
      podtretSearchData = data;
    }
  }

  static combineSearchData() {
    combinedElearningPodtretSearchData = [...elearningSearchData, ...podtretSearchData];
  }
}
