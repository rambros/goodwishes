import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {

   final kAudioStorageDirectory = 'audios/';
   final kImageStorageDirectory = 'images/';
   final kUserImageStorageDirectory = 'user_images/';

  Future<CloudStorageResult?> uploadImage({
    required File imageToUpload,
    required String title,
  }) async {
    var _imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();
    final _imageFilePath = kImageStorageDirectory + _imageFileName;
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(_imageFilePath);

    var uploadTask = firebaseStorageRef.putFile(imageToUpload);

    var storageSnapshot = await uploadTask;

    if (storageSnapshot.state == TaskState.success) {
      var downloadUrl = await storageSnapshot.ref.getDownloadURL();
      var url = downloadUrl.toString();
      return CloudStorageResult(imageUrl: url, imageFileName: _imageFileName);
    }
  }

  Future<CloudStorageResult?> uploadUserImage({
    required File imageToUpload,
    required String title,
  }) async {
    var _imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();
    final _imageFilePath = kUserImageStorageDirectory + _imageFileName;
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(_imageFilePath);

    var uploadTask = firebaseStorageRef.putFile(imageToUpload);
    
    var storageSnapshot = await uploadTask;
      
    if (storageSnapshot.state == TaskState.success) {
      var downloadUrl = await storageSnapshot.ref.getDownloadURL();
      var url = downloadUrl.toString();
      return CloudStorageResult(imageUrl: url, imageFileName: _imageFileName);
    }
  }

  Future deleteImage(String imageFile) async {
    final _imageFilePath = kImageStorageDirectory + imageFile;
    final  firebaseStorageRef =
        FirebaseStorage.instance.ref().child(_imageFilePath);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteUserImage(String imageFile) async {
    final _imageFilePath = kUserImageStorageDirectory + imageFile;
    final  firebaseStorageRef =
        FirebaseStorage.instance.ref().child(_imageFilePath);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteAudio(String audioFile) async {
    final _imageFilePath = kAudioStorageDirectory + audioFile;
    final  firebaseStorageRef =
        FirebaseStorage.instance.ref().child(_imageFilePath);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<CloudStorageAudioResult?> uploadAudioFile(File audioToUpload) async {
    var _path = audioToUpload.path;
    var audioFileName = _path.split('/').last;
    var _extension = audioFileName.toString().split('.').last;

    final _audioFilePath = kAudioStorageDirectory + audioFileName;
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(_audioFilePath);

    var uploadTask = firebaseStorageRef.putFile(audioToUpload,
          SettableMetadata(
            contentType: 'audio/$_extension',
      ),);

    var storageSnapshot = await uploadTask;

    if (storageSnapshot.state == TaskState.success) {
      var downloadUrl = await storageSnapshot.ref.getDownloadURL();
      var url = downloadUrl.toString();
      return CloudStorageAudioResult(
          audioUrl: url, audioFileName: audioFileName);
    }
  }
}

class CloudStorageResult {
  final String? imageUrl;
  final String? imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}

class CloudStorageAudioResult {
  final String? audioUrl;
  final String? audioFileName;

  CloudStorageAudioResult({this.audioUrl, this.audioFileName});
}
