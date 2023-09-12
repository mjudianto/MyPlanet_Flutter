import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/elearninTest/elearning_test_page_controller.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';

class ElearningFeedbackPage extends StatelessWidget {
  ElearningFeedbackPage({super.key});

  final ElearningTestPageController elearningTestPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(type: 'text', title: 'Feedback',),
      body: Column(
        children: [
          const SizedBox(height: 25,),
          Center(
            child: SizedBox(
              width: 260,
              child: Text(
                elearningTestPageController.elearningTest.data?[0].judul ?? "",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: semiBold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
              },
            ),
          )
        ],
      ),
    );
  }
}
