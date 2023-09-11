import 'package:http/http.dart' as http;
import '../../models/podtrets/podtret_model.dart';
import 'package:myplanet/helpers/global_variable.dart';

class PodtretsProvider {
  static Future<Podtret> getActivePodtrets(String userToken) async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariable.apiUrl}/podtrets/getActivePodtrets'),
        headers: {
          'Authorization' : 'bearer $userToken',
        }
      );
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


