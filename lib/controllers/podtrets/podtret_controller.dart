import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/models/podtrets/podtret_model.dart';
import 'package:myplanet/providers/podtrets/podtret_provider.dart';

class PodtretController {
  static Future<Podtret> fetchNewPodtrets() async {
    try {
      Podtret userCourses = Podtret();
      
      String? userToken = await GlobalVariable.secureStorage.read(key: 'user_token');
      userCourses = await PodtretsProvider.getActivePodtrets(userToken ?? "");
      return userCourses;
    } on Exception catch(e) {
      // print('error: $e');
      throw Exception('error: $e');
    }
  }
}