import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_input/page_preview_camera.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  File? _image1;
  File? _image2;
  File? _image3;

  Future showPreview(File file, int containerIndex) async {
    File? arq = await Get.to(
      () => PreviewPageCamera(
        file: file,
        checkImage: false,
      ),
    );

    if (arq != null) {
      setState(() {
        if (containerIndex == 1) {
          _image1 = File(arq.path);
        } else if (containerIndex == 2) {
          _image2 = File(arq.path);
        } else if (containerIndex == 3) {
          _image3 = File(arq.path);
        }
      });
    }
    Get.back();
  }

  Widget _buildImageContainer(int containerIndex) {
    File? imageFile;
    if (containerIndex == 1) {
      imageFile = _image1;
    } else if (containerIndex == 2) {
      imageFile = _image2;
    } else if (containerIndex == 3) {
      imageFile = _image3;
    }

    return GestureDetector(
      onTap: () async {
        Get.to(
          () => CameraCamera(
            onFile: (File file) => showPreview(
              file,
              containerIndex,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            width: 80,
            height: 100.0,
            color: Colors.grey[300],
            child: imageFile != null
                ? Image.file(imageFile, fit: BoxFit.cover)
                : Icon(Icons.camera_alt, size: 50.0, color: Colors.grey[800]),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  if (imageFile != null) {
                    await Get.to(() => PreviewPageCamera(
                          file: imageFile!,
                          checkImage: true,
                        ));
                  }
                },
                icon: Icon(Icons.fullscreen),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    if (containerIndex == 1) {
                      _image1 = null;
                    } else if (containerIndex == 2) {
                      _image2 = null;
                    } else if (containerIndex == 3) {
                      _image3 = null;
                    }
                  });
                },
                icon: Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildImageContainer(1),
          _buildImageContainer(2),
          _buildImageContainer(3),
        ],
      ),
    );
  }
}
