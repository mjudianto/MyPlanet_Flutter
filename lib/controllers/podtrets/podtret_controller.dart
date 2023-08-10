import 'package:myplanet/models/podtrets/podtret_model.dart';
import 'package:myplanet/providers/podtrets/podtret_provider.dart';

class PodtretController {
  static Future<Podtret> fetchNewPodtrets() async {
    try {
      Podtret userCourses = Podtret();
      userCourses = await PodtretsProvider.getActivePodtrets();
      return userCourses;
    } on Exception catch(e) {
      throw Exception('error: $e');
    }
  }
}