import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(180); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/appBarBackground.png'), // Replace this with the path to your background image
          fit: BoxFit.cover, // Adjust the image fit to cover the entire container
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(58), // Radius to make the corners round
        ),
      ),
      child: AppBar(
        title: SizedBox(
          height: preferredSize.height, // Set the height of the SizedBox to the preferredSize height
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
                      width: 155, // Set the width of the logo image
                      height: 45, // Set the height of the logo image
                    ),
                    const Spacer(), // Add a spacer to push the widgets to the edges
                    IconButton(
                      onPressed: () {
                        // Handle the first alert circular button action here
                      },
                      icon: const Icon(Icons.newspaper),
                    ),
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: const Icon(Icons.notifications_none_outlined),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Row(
                  children: [
                    const SizedBox(width: 12), // Add some spacing to the left
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari E-learning atau PODTRET',
                              border: InputBorder.none,
                              contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              prefixIcon: Icon(Icons.search), // Search icon inside the search bar
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add some spacing to the right
                  ],
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: preferredSize.height, // Set the toolbar height to the preferredSize height
        elevation: 0, // Remove shadow from the AppBar
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}