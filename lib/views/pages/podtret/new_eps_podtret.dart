import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/widgets/card/card_top_eps_podtret.dart';

class NewEpsPodtret extends StatelessWidget {
  const NewEpsPodtret({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(top: 18),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: blackColor,
            ),
          ),
          title: Padding(
            padding:
                const EdgeInsets.only(top: 18), // Atur padding atas untuk Text
            child: Text(
              'Episode Baru',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // * LIST ITEM
          Container(
            margin: const EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
                CardTopEps(),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(),
      body: content(),
    );
  }
}
