import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/helpers/global_variable.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/elearning/pdf_page/pdf_page_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class PdfPage extends StatelessWidget {
  PdfPage({super.key});

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  PdfPageController pdfPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Text Document',
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Ganti dengan ikon "Back" yang sesuai
            color: blackColor, // Ganti dengan warna yang Anda inginkan
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: blackColor,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: Obx(() => SfPdfViewer.network(
            '${GlobalVariable.myplanetUrl}/${pdfPageController.pdfPath.value}',
            key: _pdfViewerKey,
          )),
      // SfPdfViewer.network(
      //   '${GlobalVariable.myplanetUrl}/${pdfPageController.pdfPath}',
      //   key: _pdfViewerKey,
      // ),
    );
  }
}
