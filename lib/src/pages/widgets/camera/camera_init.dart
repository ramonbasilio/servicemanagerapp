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

class CameraInit extends StatefulWidget {
  final Function(List<File>) finalReturn;
  const CameraInit({
    super.key,
    required this.finalReturn,
  });

  @override
  State<CameraInit> createState() => _CameraInitState();
}

class _CameraInitState extends State<CameraInit> {
  File? galleryFile;
  List<File> listImage = [];

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          listImage.isEmpty
              ? const SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Text('Sem imagens'),
                  ),
                )
              : GestureDetector(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List<Widget>.generate(
                        listImage.length,
                        (int index) {
                          return SizedBox(
                            width: 210,
                            height: 250,
                            child: GestureDetector(
                              onTap: () async {
                                Get.to(() => PreviewPageCamera(
                                      file: listImage[index],
                                      checkImage: true,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Image.file(
                                    fit: BoxFit.fitWidth,
                                    width: 200,
                                    height: 200,
                                    listImage[index],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        listImage.removeAt(index);
                                        widget.finalReturn(listImage);
                                      });
                                    },
                                    icon: const Icon(Icons.delete_rounded),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
          IconButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              icon: const Icon(Icons.add))
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
                          listImage.add(galleryFile!);
                          widget.finalReturn(listImage);
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
                          uint8List: result, fileName: '${DateTime.now()}.jpeg');
                      setState(
                        () {
                          galleryFile = File(resultPath);
                          if (galleryFile != null) {
                            listImage.add(galleryFile!);
                            widget.finalReturn(listImage);
                          }
                        },
                      );
                      Get.back();
                      Get.back();
                    }),
              ],
            ),
          );
        });
  }
}
