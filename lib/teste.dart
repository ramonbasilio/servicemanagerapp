import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_share_service_order.dart';
import 'package:servicemangerapp/src/pdf/genarate_pdf.dart';

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.green.shade100,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  File pdfFile = await GeneratePdf().createPdf();
                  PdfViewer().viewPdf(pdfFile);
                },
                child: Text('Gerar PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
