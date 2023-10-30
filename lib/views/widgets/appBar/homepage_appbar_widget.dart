import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/routes/route_name.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearningCourse/elearning_course_page_controller.dart';
import 'package:myplanet/views/pages/news/news_page.dart';
import 'package:myplanet/views/pages/notification/notification_page.dart';
import 'package:myplanet/views/pages/podtret/podtretContent/podtret_konten_controller.dart';
import 'package:searchfield/searchfield.dart';

// ignore: must_be_immutable
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomePageAppBar({Key? key,}) : super(key: key);

  dynamic data;

  @override
  Size get preferredSize =>
      const Size.fromHeight(155); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    data = GlobalVariable.combinedElearningPodtretSearchData ?? [];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/appBarBackground.png'), // Replace this with the path to your background image
          fit: BoxFit
              .cover, // Adjust the image fit to cover the entire container
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(58), // Radius to make the corners round
        ),
      ),
      child: AppBar(
        title: SizedBox(
          height: preferredSize
              .height, // Set the height of the SizedBox to the preferredSize height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo.png', // Replace this with the path to your logo image
                      width: 141, // Set the width of the logo image
                      height: 32, // Set the height of the logo image
                    ),
                    const Spacer(), // Add a spacer to push the widgets to the edges
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NewsPage(), // Ganti dengan nama yang sesuai
                          ),
                        );
                      },
                      icon: const Icon(Icons.newspaper),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationPage(), // Ganti dengan nama yang sesuai
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_none_outlined),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17.0, left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(child: SearchBar(data: data,)),
                  ],
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: preferredSize
            .height, // Set the toolbar height to the preferredSize height
        elevation: 0, // Remove shadow from the AppBar
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({
    super.key,
    this.data
  });

  List<dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 330,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: SearchField(
          hint: "Cari E-learning atau PODTRET",
          searchInputDecoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 2),
                borderRadius: BorderRadius.circular(100)),
            hintStyle: const TextStyle(
              fontSize: 13,
              color: secondaryColor,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: secondaryColor,
            ),
          ),
          itemHeight: 50,
          maxSuggestionsInViewPort: 6,
          suggestionsDecoration: SuggestionDecoration(
              padding: const EdgeInsets.all(4),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          onSuggestionTap: (value) {
            if(value.searchKey.toString().toLowerCase().startsWith('eps'.toLowerCase())) {
              PodtretKontenController podtretKontenController = Get.find();
              podtretKontenController.podtret = value.item;

              Get.toNamed(RouteName.podtretContent);
            } else {
              ElearningCoursePageController elearningCoursePageController = Get.find();
              elearningCoursePageController.setElearningCourseId(value.item.toString());

              Get.toNamed(RouteName.elearningCoursePage);
            }
          },
          suggestions: data!
              .map((e) => SearchFieldListItem(
                    e.judul,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        e.judul,
                        style: blackTextStyle.copyWith(
                            fontSize: 13, fontWeight: medium),
                      ),
                    ),
                    item: e.judul.toString().toLowerCase().startsWith('eps'.toLowerCase()) ? e : e.elearningCourseId
                  ))
              .toList(),
        ),
      ),
    );
  }
}
