import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static int gerenateNumerServiceOrder() {
    int min = 10000;
    int max = 99999;
    return min + Random().nextInt((max + 1) - min);
  }

  static String convertDate(DateTime datetime) {
    return "${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year} - ${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}";
  }

  static Future<String> saveImage(
      {required Uint8List uint8List, required String fileName}) async {
    // Obtém o diretório temporário do dispositivo
    final directory = await getTemporaryDirectory();

    // Define o caminho completo para o arquivo
    final path = '${directory.path}/$fileName';

    // Cria o arquivo e escreve os bytes
    final file = File(path);
    await file.writeAsBytes(uint8List);

    // Retorna o caminho para o arquivo de imagem salvo
    return path;
  }
}
