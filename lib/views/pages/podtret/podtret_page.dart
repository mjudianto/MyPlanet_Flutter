import 'package:flutter/material.dart';
import 'package:myplanet/views/widgets/appBar/appbar_podtret.dart';

class PodtretPage extends StatefulWidget {
  const PodtretPage({super.key});

  @override
  State<PodtretPage> createState() => _PodtretPageState();
}

class _PodtretPageState extends State<PodtretPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: const PageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarPodtret(
              type: 'search',
            ),
            SizedBox(height: 200, child: Center(child: Text('Podtret Page'))),
          ],
        ),
      ),
    );
  }
}
