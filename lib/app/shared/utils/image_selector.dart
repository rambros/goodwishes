import 'dart:io';

import 'package:image_picker/image_picker.dart';


class ImageSelector {
  Future<File> selectImage() async {
    final _picker = ImagePicker();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return File(pickedFile!.path);
    } catch (e) {
      throw Exception;
    }
    
  }

}

