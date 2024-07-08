import 'dart:io';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  final List<File> _listFileImage = [];
  List<File> get listFileImage => _listFileImage;


  void addFile(File file) {
    _listFileImage.add(file);
    notifyListeners();
  }
}
