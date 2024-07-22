import 'package:open_file/open_file.dart';
import 'dart:io';

class PdfViewer {
  Future<void> viewPdf(File file) async {
    final filePath = file.path;
    await OpenFile.open(filePath);
  }
}