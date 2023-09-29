import 'package:myplanet/models/podtrets/podtret_model.dart';

abstract class RouteName {
  static const splashScreen = '/splash_screen';

  static const loginPage = '/login';
  static const homePage = '/home';
  static const dashboardPage = '/dashboard';

  static const elearningPage = '/elearning';
  static const elearningCoursePage = '/elearning/course';
  static const elearningTestPage = '/elearning/course/test';
  static const elearningFeedbackPage = '/elearning/course/feedback';

  static const podtretPage = '/podtret';
  static const recomendationPodtret = '/podtret/recomendation_podtret';
  static const newEpisodePodtret = '/podtret/new_episode_podtret';
  static const topEpisodePodtret = '/podtret/top_podtret';
  static const podtretContent = '/podtret/podtret_contents';

  static const communityPage = '/community';
  static const profilePage = '/profile';
}
