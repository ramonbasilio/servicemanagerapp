import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_share_service_order.dart';
import 'package:servicemangerapp/src/pages/widgets/camera_widget_2.dart';
import 'package:servicemangerapp/src/pdf/genarate_pdf.dart';
import 'package:servicemangerapp/src/pdf/view_pdf_2.dart';

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
            CameraWidget2(
              finalReturn: (List<File> value) {
                for (var x in value) {
                  print('retorno: $x');
                }
              },
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  Client client = Client(
                    name: 'Will',
                    phone: '(11) 98542-1201',
                    email: 'will@gmail.com',
                  );
                  ServiceOrder serviceOrder = ServiceOrder(
                    client: client,
                    numberDoc: '10285',
                    equipment: 'Celular',
                    brand: 'Samsung',
                    model: 'S23',
                    accessories: 'sem acessórios',
                    defect: 'Tela queberada',
                    pathImages: [
                      'https://firebasestorage.googleapis.com/v0/b/servicemanager-43bad.appspot.com/o/contato%40fullmedcare.com%2F7ac8f826-c672-481e-86db-52395b50fe89%2F23984%2Fimages%2FCAP525949345366880381.jpg?alt=media&token=ffc5f2e2-c351-4145-b057-bbd2351a97e7',
                      'https://firebasestorage.googleapis.com/v0/b/servicemanager-43bad.appspot.com/o/contato%40fullmedcare.com%2F7ac8f826-c672-481e-86db-52395b50fe89%2F23984%2Fimages%2FCAP525949345366880381.jpg?alt=media&token=ffc5f2e2-c351-4145-b057-bbd2351a97e7',
                      'https://firebasestorage.googleapis.com/v0/b/servicemanager-43bad.appspot.com/o/contato%40fullmedcare.com%2F7ac8f826-c672-481e-86db-52395b50fe89%2F23984%2Fimages%2FCAP525949345366880381.jpg?alt=media&token=ffc5f2e2-c351-4145-b057-bbd2351a97e7',
                    ],
                    pathSign:
                        'https://firebasestorage.googleapis.com/v0/b/servicemanager-43bad.appspot.com/o/contato%40fullmedcare.com%2F7ac8f826-c672-481e-86db-52395b50fe89%2F23984%2Fsign%2Fsign-Graziella.jpg?alt=media&token=727ff0b6-34cb-4913-b933-7e76a5d46782',
                  );
                  File pdfFile =
                      await GeneratePdf(serviceOrder: serviceOrder).createPdf();
                  Get.to(() => ViwerPdf(
                        path: pdfFile.path,
                      ));
                },
                child: const Text('Gerar PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
