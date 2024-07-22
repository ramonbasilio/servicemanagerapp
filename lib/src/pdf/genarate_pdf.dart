import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class GeneratePdf {

  Future<File> createPdf() async {
    pw.Document doc = pw.Document();
    doc.addPage(pw.Page(
      build: (context) {
        return pw.Container(child: pw.Text('Pagina Teste'));
      },
    ));

    final output = await getApplicationCacheDirectory();
    final file = File("${output.path}/exemple.pdf");
    await file.writeAsBytes(await doc.save());
    return file;
  }

}
