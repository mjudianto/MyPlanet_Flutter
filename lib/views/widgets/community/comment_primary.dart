import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/community/btn_more.dart';
import 'package:myplanet/views/widgets/community/comment_reply.dart';

class CommentPrimary extends StatelessWidget {
  const CommentPrimary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/nanda.jpg',
                  width: 42,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: pastelSecondaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nanda Raditya',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                'EPM - IT',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                          const BtnMore()
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Good tips for designer!",
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
            child: InkWell(
              onTap: () {
                // print("Balas!");
              },
              child: Text(
                "Balas",
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
          const CommentReply(),
          const CommentReply(),
        ],
      ),
    );
  }
}
