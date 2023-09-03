import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/constant.dart';

class BoxImageCont extends StatefulWidget {
  const BoxImageCont(
      {super.key,
      required this.hightBox,
      required this.widthBox,
      required this.radis});

  final double hightBox;
  final double widthBox;
  final double radis;
  @override
  State<BoxImageCont> createState() => _BoxImageContState();
}

class _BoxImageContState extends State<BoxImageCont> {
   File? _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _showImagePickerDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick an Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Capture from Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showImagePickerDialog,
      child: Stack(children: [
        Container(
          width: widget.widthBox,
          height: widget.hightBox,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ConstantStayles.kPrimColor,
              width: 1,
            ),
          ),
          child: _pickedImage != null
              ? Image.file(
                  _pickedImage!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: CircleAvatar(
                    radius: widget.radis,
                    backgroundImage: const AssetImage(Assets.camera),
                  ),
                ),
        ),
      ]),
    );
  }
}
