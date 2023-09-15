import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';

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
    return Container(
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
              height: 40,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari PODTRET',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons
                        .search), // Ikon pencarian di dalam kotak pencarian
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
