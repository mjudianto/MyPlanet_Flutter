import 'package:flutter/material.dart';
import 'package:myplanet/controllers/elearnings/elearning_course_controller.dart';
import 'package:myplanet/controllers/podtrets/podtret_controller.dart';
import 'package:myplanet/models/elearnings/elearning_course_model.dart';
import 'package:myplanet/models/podtrets/podtret_model.dart';
import 'package:myplanet/views/widgets/appBar/homepage_appbar_widget.dart';
import 'package:myplanet/views/widgets/card/card_horizontal_widget.dart';
import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';
import 'package:myplanet/theme.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ElearningCourse>? _userCoursesFuture;
  Future<Podtret>? _newPodtrets;

  @override
  void initState() {
    super.initState();

    _userCoursesFuture = ElearningCourseController.fetchUserCourses();
    _newPodtrets = PodtretController.fetchNewPodtrets();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: const HomePageAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const HomePageAppBar(),
              
              const SectionTitle(title: 'New Course'),
    
              FutureBuilder(
                future: _userCoursesFuture,
                builder: (context, snapshot) { 
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future to complete
                    return 
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle any errors that occurred during the Future execution
                    return
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Error: Error: Data Load Failed',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    // If the Future completed successfully, display the data
                    if (snapshot.data != null) {
                      var elearningCourses = snapshot.data!;
                      elearningCourses.data!.sort((course1, course2) => (course2.elearningCourseId ?? 0).compareTo(course1.elearningCourseId ?? 0));
                      final coursesToShow = elearningCourses.data?.take(5).toList() ?? [];
    
                      return SizedBox(
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: coursesToShow.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 8.0), // Separator width equals padding
                          itemBuilder: (context, index) {
                            final course = coursesToShow[index];
                            return CardVerticalWidget(
                              thumbnail: course.thumbnail, 
                              title: course.judul, 
                              subTitle: '${(course.totalLesson ?? 0) + (course.totalTest ?? 0) } lessons • ', 
                              subTitle2: course.createdBy,
                              rating: course.averageRating,
                              ratingCount: course.responseCount,
                              targetLocation: '/elearning/course/${course.elearningCourseId}',
                            );
                          },
                        ),
                      );
                    } else {
                      // Handle the case when there is no data
                      return const Text('No data available.');
                    }
                  }
                },
              ),
              
              const SectionTitle(title: 'Continue Learning'),
    
              FutureBuilder(
                future: _userCoursesFuture,
                builder: (context, snapshot) { 
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future to complete
                    return 
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle any errors that occurred during the Future execution
                    return
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Error: Error: Data Load Failed',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    // If the Future completed successfully, display the data
                    if (snapshot.data != null) {
                      var elearningCourses = snapshot.data!;
                      elearningCourses.data!.sort(
                        (course1, course2) => double.parse(course2.percentage.toString()).compareTo(double.parse(course1.percentage.toString()))
                      );
    
                      final coursesToShow = elearningCourses.data!.where(
                        (course) => course.percentage.toString() != '0.00' && course.percentage.toString() != '100.00'
                      ).toList();
    
                      return SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: coursesToShow.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 8.0), // Separator width equals padding
                          itemBuilder: (context, index) {
                            final course = coursesToShow[index];
                            return CardHorizontalWidget(
                              thumbnail: course.thumbnail,
                              category: course.kategori,
                              title: course.judul,
                              percentage: double.parse(course.percentage.toString()),
                              targetLocation: '/elearning/${course.elearningCourseId}',
                            );
                          },
                        ),
                      );
    
    
                    } else {
                      // Handle the case when there is no data
                      return const Text('No data available.');
                    }
                  }
                },
              ),
    
              const SectionTitle(title: 'New Podtret'),
    
              FutureBuilder(
                future: _newPodtrets,
                builder: (context, snapshot) { 
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future to complete
                    return 
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle any errors that occurred during the Future execution
                    return
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Error: Error: Data Load Failed',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    // If the Future completed successfully, display the data
                    if (snapshot.data != null) {
                      var podtrets = snapshot.data!;
    
                      final podtretToShow = podtrets.data?.take(5).toList() ?? [];
    
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Column(
                                children:
                                List.generate(
                                  podtretToShow.length, 
                                  (index) {
                                    final podtret = podtretToShow[index];
                                    DateTime dateTime = DateTime.parse(podtret.publishDate.toString());
                                    String publishDate = DateFormat('dd MMMM yyyy').format(dateTime);
    
                                    return CardHorizontalWidget(
                                        thumbnail: podtret.thumbnail, 
                                        category: podtret.nama,
                                        title: podtret.judul, 
                                        subTitle: '${podtret.views}x watched • $publishDate',
                                        width: 400,
                                        thumbnailHeight: 80,
                                        thumbnailWidht: 150,
                                        titleWidth: 175,
                                        subTitleWidth: 175,
                                    );
                                  }
                                )
                          ),
                      );
                    } else {
                      // Handle the case when there is no data
                      return const Text('No data available.');
                    }
                  }
                },
              ),
    
            ],
          ),
        ),
        
      ),
    );
  }
}


class SectionTitle extends StatelessWidget {

  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 22.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: bold,
              color: blackColor,
            ),
          ),
          const Spacer(),
          Text(
            'See More',
            style: TextStyle(
              color: primaryColor,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }
}
