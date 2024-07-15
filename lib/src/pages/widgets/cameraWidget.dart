import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/page_preview_camera.dart';

class CameraWidget extends StatefulWidget {
  final Function(List<String>) finalReturn;
  const CameraWidget({
    required this.finalReturn,
    super.key,
  });

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  File? _image1;
  File? _image2;
  File? _image3;
  final List<String> _listFiles = List.filled(3, '');

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
          _listFiles[0] = arq.path;
          widget.finalReturn(_listFiles);
        } else if (containerIndex == 2) {
          _image2 = File(arq.path);
          _listFiles[1] = arq.path;
          widget.finalReturn(_listFiles);
        } else if (containerIndex == 3) {
          _image3 = File(arq.path);
          _listFiles[2] = arq.path;
          widget.finalReturn(_listFiles);
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
            onFile: (File file) {
              showPreview(
                file,
                containerIndex,
              );
            },
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
                icon: const Icon(Icons.fullscreen),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    if (containerIndex == 1) {
                      _image1 = null;
                      _listFiles[0] = '';
                      widget.finalReturn(_listFiles);
                    } else if (containerIndex == 2) {
                      _image2 = null;
                      _listFiles[1] = '';
                      widget.finalReturn(_listFiles);
                    } else if (containerIndex == 3) {
                      _image3 = null;
                      _listFiles[2] = '';
                      widget.finalReturn(_listFiles);
                    }
                  });
                },
                icon: const Icon(Icons.delete),
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
