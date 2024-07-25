import 'dart:io';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  List<String> listPathImages = [];
  String urlDownload = '';
  bool controllSign = false;

  void addPathList(List<String> list, String url) {
    listPathImages = list;
    urlDownload = url;
    print('exibindo lista de imagens URL: $listPathImages');
    notifyListeners();
  }

  void setControllSign(bool value) {
    controllSign = value;
    notifyListeners();
  }

  List<String> getList() {
    return listPathImages;
  }

  String getUrl() {
    return urlDownload;
  }
}
