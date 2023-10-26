import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:searchfield/searchfield.dart';

class AppBarPodtret extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPodtret({Key? key, required this.type, this.title})
      : super(key: key);

  final String type;
  final String? title;

  @override
  Size get preferredSize =>
      const Size.fromHeight(105); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              type == 'search'
                  ? const SearchBar()
                  : Title(
                      title: title ?? "",
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

class Title extends StatelessWidget {
  final String title;

  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: whiteColor,
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: bold),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 330,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logo_podtret.png', // Ganti dengan path gambar logo yang sesuai
                width: 50, // Sesuaikan ukuran lebar sesuai kebutuhan
                height: 32, // Sesuaikan ukuran tinggi sesuai kebutuhan
              ),
            ],
          ),
          const SizedBox(
              width:
                  10), // Menambahkan ruang di antara logo dan kotak pencarian
          Expanded(
              child: Container(
            height: 45,
            width: 330,
            decoration: BoxDecoration(
              color:
                  whiteColor, // Ganti dengan warna latar belakang yang Anda inginkan
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: SearchField(
                hint: "Cari PODTRET",
                searchInputDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: secondaryColor,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                ),
                itemHeight: 50,
                maxSuggestionsInViewPort: 6,
                suggestionsDecoration: SuggestionDecoration(
                  padding: const EdgeInsets.all(4),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onSuggestionTap: (value) {
                  print("E-learning");
                },
                suggestions: [
                  'Neop General',
                  'BEP',
                  'CDOB',
                  'Enseval Bootcamp',
                  'Neop Warehouse',
                  'Etika Bisnis',
                  'Innochamp',
                  'Test'
                ]
                    .map((e) => SearchFieldListItem(
                          e,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              e,
                              style: blackTextStyle.copyWith(
                                  fontSize: 13, fontWeight: medium),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
