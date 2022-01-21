  import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> selectAudioFile() async {
    File? audioFile;
    try {
        var result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if(result != null) {
             audioFile = File(result.files.single.path!);
        }
    } catch (e) {
      print('Unsupported operation' + e.toString());
      return null;
    }
    return audioFile;
  }


  String transformMilliseconds(int milliseconds) {
    var hundreds = (milliseconds / 10).truncate();
    var seconds = (hundreds / 100).truncate();
    var minutes = (seconds / 60).truncate();

    var minuteStr = (minutes % 60).toString().padLeft(2, '0');
    var secondStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }