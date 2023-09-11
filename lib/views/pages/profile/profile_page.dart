import 'package:flutter/material.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
// import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // appBar: const PageAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, 
            children: [
              PageAppBar(type: 'text',),

              SizedBox(
                height: 200,
                child: Center(
                  child: Text('Profile Page')
                )
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}
