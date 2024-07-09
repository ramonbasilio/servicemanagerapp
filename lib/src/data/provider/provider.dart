import 'dart:io';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  List<String> listPathImages = [];
  String urlDownload = '';

  void addPathList(List<String> list, String url) {
    listPathImages = list;
    urlDownload = url;
    notifyListeners();
  }

  List<String> getList() {
    return listPathImages;
  }

  String getUrl() {
    return urlDownload;
  }
}
