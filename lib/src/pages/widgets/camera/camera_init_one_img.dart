import 'dart:io';
import 'dart:typed_data';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicemangerapp/src/pages/widgets/camera/camera_open.dart';
import 'package:servicemangerapp/src/pages/widgets/page_preview_camera.dart';
import 'package:servicemangerapp/src/utils/utils.dart';

class CameraInitOneImg extends StatefulWidget {
  final Function(String) finalReturn;
  const CameraInitOneImg({
    super.key,
    required this.finalReturn,
  });

  @override
  State<CameraInitOneImg> createState() => _CameraInitOneImgState();
}

class _CameraInitOneImgState extends State<CameraInitOneImg> {
  File? galleryFile;
  List<File> listImage = [];
  String imagePartPath = '';

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: imagePartPath.isEmpty ? 50 : 300,
      child: Column(
        children: [
          imagePartPath.isEmpty
              ? Row(
                  children: [
                    const Center(
                      child: Text('Imagem da peça'),
                    ),
                    IconButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Imagem da Peça'),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.to(() => PreviewPageCamera(
                              file: File(imagePartPath),
                              checkImage: true,
                            ));
                      },
                      child: Image.file(
                        fit: BoxFit.fitWidth,
                        width: 200,
                        height: 200,
                        File(imagePartPath),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          imagePartPath = '';
                        });
                      },
                      icon: const Icon(Icons.delete_rounded),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        context: context,
        builder: (context) {
          return SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.image_outlined),
                  title: const Text('Galeria'),
                  onTap: () async {
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    XFile? xfilePick = pickedFile;
                    Uint8List pictureConverted = await xfilePick!.readAsBytes();
                    Uint8List? result = await Get.to(
                      () => ImageEditor(
                        image: pictureConverted, // <-- Uint8List of image
                      ),
                    );
                    String resultPath = await Utils.saveImage(
                        uint8List: result!, fileName: xfilePick.name);
                    setState(
                      () {
                        galleryFile = File(resultPath);
                        if (galleryFile != null) {
                          imagePartPath = galleryFile!.path;
                          widget.finalReturn(galleryFile!.path);
                        }
                      },
                    );
                    Get.back();
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                    onTap: () async {
                      late Uint8List result;
                      await availableCameras().then((value) async {
                        result = await Get.to(() => CameraOpen(cameras: value));
                      });
                      String resultPath = await Utils.saveImage(
                          uint8List: result,
                          fileName: '${DateTime.now()}.jpeg');
                      setState(
                        () {
                          galleryFile = File(resultPath);
                          if (galleryFile != null) {
                            imagePartPath = galleryFile!.path;
                            widget.finalReturn(galleryFile!.path);
                          }
                        },
                      );
                      Get.back();
                    }),
              ],
            ),
          );
        });
  }
}
