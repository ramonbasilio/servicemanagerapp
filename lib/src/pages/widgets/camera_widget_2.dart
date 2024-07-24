import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicemangerapp/src/pages/widgets/page_preview_camera.dart';

class CameraWidget2 extends StatefulWidget {
  final Function(List<File>) finalReturn;
  const CameraWidget2({required this.finalReturn, super.key});

  @override
  State<CameraWidget2> createState() => _CameraWidget2State();
}

class _CameraWidget2State extends State<CameraWidget2> {
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
                              onTap: () {
                                Get.to(() => PreviewPageCamera(
                                      file: listImage[index],
                                      checkImage: true,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Image.file(
                                    fit: BoxFit.fill,
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
                  onTap: () => {getImage(ImageSource.gallery), Get.back()},
                ),
                ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                    onTap: () => {getImage(ImageSource.camera), Get.back()}),
              ],
            ),
          );
        });
  }

  Future<void> getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
          if (galleryFile != null) {
            listImage.add(galleryFile!);
            widget.finalReturn(listImage);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
