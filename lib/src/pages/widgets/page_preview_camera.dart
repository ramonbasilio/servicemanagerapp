import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewPageCamera extends StatelessWidget {
  File file;
  bool checkImage;

  PreviewPageCamera({super.key, required this.file, required this.checkImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(file, fit: BoxFit.contain),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    checkImage
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.check, //FIRAR FOTO
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () => Get.back(result: file),
                                ),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close, //FECHAR
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
