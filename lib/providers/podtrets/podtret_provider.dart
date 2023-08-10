import 'package:http/http.dart' as http;
import '../../models/podtrets/podtret_model.dart';

class PodtretsProvider {
  static const String baseUrl = "https://myplanet.enseval.com:3000"; // Replace with your API base URL

  static Future<Podtret> getActivePodtrets() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/podtrets/getActivePodtrets'));
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return podtretFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


