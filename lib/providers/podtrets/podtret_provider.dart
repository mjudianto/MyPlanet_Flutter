import 'package:http/http.dart' as http;
import 'package:myplanet/models/podtrets/podtret_comment_models.dart';
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

  static podtretLike(String userToken, String podtretId) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/podtrets/podtretLike'),
        headers: {
          'Authorization' : 'bearer $userToken',
        },
        body : {
          "podtretId" : podtretId
        }
      );
      if (response.statusCode == 200) {
        
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<PodtretComment> getPodtretComments(String userToken, String podtretId) async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariable.apiUrl}/podtrets/podtretComment/$podtretId'),
        headers: {
          'Authorization' : 'bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return podtretCommentFromJson(jsonResponse);
      } else {
        return PodtretComment();
        // throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static submitPodtretComment(String userToken, String podtretId, String comment) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/podtrets/podtretComment/$podtretId'),
        headers: {
          'Authorization' : 'bearer $userToken',
        },
        body: {
          "comment" : comment
        }
      );
      if (response.statusCode == 200) {
        // var jsonResponse = response.body;
        // print(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static submitPodtretCommentReply(String userToken, String podtretCommentId, String comment) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/podtrets/podtretCommentReply'),
        headers: {
          'Authorization' : 'bearer $userToken',
        },
        body: {
          "podtretCommentId" : podtretCommentId,
          "comment" : comment
        }
      );
      if (response.statusCode == 200) {
        // var jsonResponse = response.body;
        // print(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static setUserPodtretRecord(String userToken, String podtretId) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariable.apiUrl}/userRecords/userPodtretRecord'),
        headers: {
          'Authorization' : 'bearer $userToken',
        },
        body: {
          "podtretId" : podtretId,
        }
      );
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        print(jsonResponse);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


