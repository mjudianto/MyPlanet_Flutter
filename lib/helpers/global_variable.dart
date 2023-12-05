import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:myplanet/models/campaign_model.dart';

class GlobalVariable {
  static String currentUrl = '';
  static String apiUrl = 'https://myplanet-apiapps.enseval.com/';
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Map<String, dynamic> userData = {};
  static String myplanetUrl = 'https://myplanet.enseval.com';
  static bool posterShown = false;
  static Campaign campaigns = Campaign();

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

  static Future<SecurityContext> get globalContext async {
    try {
      final sslCert = await rootBundle.load('assets/certificate.pem');
      SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

      // Attempt to establish a connection or validate the certificate
      // For instance, try to connect to a secure endpoint
      // Replace 'https://example.com' with an actual secure endpoint
      HttpClient client = HttpClient(context: securityContext);
      HttpClientRequest request = await client.getUrl(Uri.parse('https://myplanet-apiapps.enseval.com/'));
      HttpClientResponse response = await request.close();

      // If the connection succeeds without throwing an error, return the validated context
      return securityContext;
    } catch (e) {
      // Use the fallback certificate if the first one is not valid or an error occurs
      final sslCertFallback = await rootBundle.load('assets/enseval_intranet_certificate.pem');
      SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(sslCertFallback.buffer.asInt8List());
      return securityContext;
    }
  }

  static Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}
