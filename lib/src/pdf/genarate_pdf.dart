import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:http/http.dart' show get;
import 'package:servicemangerapp/src/utils/utils.dart';

class GeneratePdf {
  ServiceOrder serviceOrder;
  GeneratePdf({required this.serviceOrder});

  Future<List<MemoryImage>> listImages() async {
    List<MemoryImage> _list = [];
    for (var path in serviceOrder.pathImages) {
      if (path.isNotEmpty) {
        var response = await get(Uri.parse(path));
        var data = response.bodyBytes;
        final image = MemoryImage(data);
        _list.add(image);
      }
    }
    return _list;
  }

  Future<File> createPdf() async {
    var url = serviceOrder.pathSign;
    var response = await get(Uri.parse(url));
    var data = response.bodyBytes;
    final imageSing = MemoryImage(data);

    List<MemoryImage> listMemoryImagem = await listImages();

    MemoryImage imageLogo = MemoryImage(
        (await rootBundle.load('lib/assets/logo-app.png'))
            .buffer
            .asUint8List());

    MemoryImage imageSignRamon = MemoryImage(
        (await rootBundle.load('lib/assets/assinatura-ramon.png'))
            .buffer
            .asUint8List());

    final pdf = Document();
    pdf.addPage(
      index: 0,
      MultiPage(
        pageFormat:
            PdfPageFormat.a4.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
        build: (context) {
          return [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Assistência Técnica'),
                          Text(
                              'Av. Otávio Spigarolo, 343 - Vila Rosina, Caieiras - SP, 07749-180'),
                          Text('(11) 98686-3126'),
                          Text('suporte@assistenciatecnica.com.br'),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image(imageLogo),
                      )
                    ],
                  ),
                  Divider(),
                  Center(
                      child: Text('ORDEM DE SERVIÇO: ${serviceOrder.numberDoc}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DADOS DO CLIENTE'),
                      Text('Nome: ${serviceOrder.client.name}'),
                      Text('Telefone: ${serviceOrder.client.phone}'),
                      Text('Email: ${serviceOrder.client.email}'),
                    ],
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DADOS DO EQUIPAMENTO'),
                      Text('Equipamento: ${serviceOrder.equipment}'),
                      Text('Marca: ${serviceOrder.brand}'),
                      Text('Modelo: ${serviceOrder.model}'),
                      Text('Acessórios: ${serviceOrder.accessories}'),
                      Text('Defeito: ${serviceOrder.defect}'),
                      Text(
                          'Entregue em: ${Utils.convertDate(serviceOrder.date!)}')
                    ],
                  ),
                  Divider(),
                  Text('Fotos do equipamento'),
                  Row(
                      children: List<Widget>.generate(listMemoryImagem.length, (int index) {
                    return Expanded(child: Container(
                      height: 100,
                      margin: const EdgeInsets.all(5),
                      color: PdfColors.amber,
                      child: Image(listMemoryImagem[index]) 
                      ));
                  })),
                  Divider(),
                  Center(child: Text('Assinaturas')),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image(imageSing, width: 100, height: 100),
                            ),
                            SizedBox(width: 100, child: Divider()),
                            Text('Cliente: ${serviceOrder.client.name}'),
                          ],
                        ), //imageSignRamon
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image(imageSignRamon,
                                  width: 100, height: 100),
                            ),
                            SizedBox(width: 100, child: Divider()),
                            Text('Técnico: Ramon Basilio'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ];
        },
      ),
    );

    final output = await getApplicationCacheDirectory();
    final file = File("${output.path}/exemple.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
