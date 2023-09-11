import 'package:flutter/material.dart';
import 'package:myplanet/views/widgets/appBar/appbar.dart';
// import 'package:myplanet/views/widgets/card/card_vertical_widget.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

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
              PageAppBar(type: 'logo',),

              SizedBox(
                height: 200,
                child: Center(
                  child: Text('Community Page')
                )
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}
