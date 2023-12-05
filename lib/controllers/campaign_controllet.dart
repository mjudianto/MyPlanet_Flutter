import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/campaign_model.dart';
import 'package:http/http.dart' as http;

class CampaignController {
  static fetchActiveCampaign() async {
    try {
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      final response = await http.get(Uri.parse('${GlobalVariable.apiUrl}/campaign/campaign'), headers: {
        'Authorization': 'bearer $userToken',
      });

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return campaignFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } on Exception catch (e) {
      throw Exception('error: $e');
    }
  }
}
