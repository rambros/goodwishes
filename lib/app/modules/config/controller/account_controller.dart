import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/local_storage_service.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/user/user_repository_interface.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/image_selector.dart';

part 'account_controller.g.dart';

class AccountController = _AccountControllerBase with _$AccountController;

abstract class _AccountControllerBase with Store {
  final _userRepository = Modular.get<IUserRepository>();
  final _authenticationService = Modular.get<AuthenticationService>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _imageSelector = Modular.get<ImageSelector>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _localStorageService = Modular.get<LocalStorageService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  
  //@observable
  UserApp? userApp;

  void init() {
    userApp = _userService.currentUser;
  }

  @observable
  File? _selectedImage;

  @computed
  File? get selectedImage => _selectedImage;

  bool get isDarkTheme => _localStorageService.isDarkTheme;

  @computed
  bool get isUserEmail => userApp!.loginType == 'email' ? true : false;

  //@action
  void changeSelectImage(value) => _selectedImage = value;

  @computed
  bool get userHasNoImageUrl => userApp!.userImageUrl == null ? true : false;

  @action
  Future selectImage() async {
    final File? tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      await cropProfileImage();
    }
  }

  Future<void> cropProfileImage() async {
    var cropped = await ImageCropper.cropImage(
      sourcePath: _selectedImage!.path,
      compressQuality: 80,
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      // ratioX: 1.0,
      // ratioY: 1.0,
      maxWidth: 300,
      maxHeight: 300,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Ajuste de imagem',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
    );
    _selectedImage = cropped ?? _selectedImage;
  }

  void logout() async {
    await _authenticationService.logout();
  }

  @action
  Future updateUser(
      {String? name, String? password, String? email, bool? novaImagem}) async {
        
    setBusy(true);

    var imageUrl;
    var imageFileName;
    String? oldImageFileName;

    //upload da imagem
    if (novaImagem == true) {
      //await cropProfileImage();
      oldImageFileName = userApp!.userImageFileName;
      // se é novo post ou edição da imagem, faz upload para storage
      CloudStorageResult? storageResult;
      storageResult = await _cloudStorageService.uploadUserImage(
          imageToUpload: _selectedImage!, title: userApp!.fullName!);
      imageUrl = storageResult?.imageUrl;
      imageFileName = storageResult?.imageFileName;

      String? resultUpdatePhoto = await (_userRepository.updateUserPhoto(
          userId: userApp!.uid, userImageUrl: imageUrl, userImageFileName: imageFileName ));
      
      setBusy(false);

      if (resultUpdatePhoto is String) {
        await _dialogService.showDialog(
          title: 'Não foi possivel alterar a foto',
          description: resultUpdatePhoto,
        );
      } else {
        userApp = await (_userRepository.getUser(userApp!.uid));
        _userService.setUserApp(userApp);
        //deleta anterior
        if (novaImagem == true) {
          if (oldImageFileName != null) {
            await _cloudStorageService.deleteUserImage(oldImageFileName);  
          }
        }  
      }
    }

    if ((email != null) && (email.trim() != userApp!.email)) {
      var resultaUpdateEmail =
          await _authenticationService.updateEmail(email);
      if (resultaUpdateEmail is String) {
        await _dialogService.showDialog(
          title: 'Não foi possivel alterar o email',
          description: 'É necessário sair (logoff) e fazer login. Depois tente novamente alterar o email',
        );
        userApp = await (_userRepository.getUser(userApp!.uid));
       _userService.setUserApp(userApp);
        setBusy(false);
        return;
      }
      resultaUpdateEmail =  await (_userService.updateUserEmail(email));
      if (resultaUpdateEmail is String) {
        await _dialogService.showDialog(
          title: 'Não foi possivel alterar o email',
          description: resultaUpdateEmail,
        );
      }
    }

    if ((name != null) && (name.trim() != userApp!.fullName)) {
      // update profile
      var resultaUpdateName =
          await _userService.updateUserName(name);
      if (resultaUpdateName is String) {
        await _dialogService.showDialog(
          title: 'Não foi possivel alterar o nome',
          description: resultaUpdateName,
        );
      }
    }

    if (password != null) {
      var resultaUpdatePassword =
          await _authenticationService.updatePassword(password);
      if (resultaUpdatePassword is String) {
        await _dialogService.showDialog(
          title: 'Não foi possivel alterar a senha',
          description: resultaUpdatePassword, //'É necessário sair (logoff) e fazer login. Depois tente novamente alterar o email',
        );
        userApp = await (_userRepository.getUser(userApp!.uid));
       _userService.setUserApp(userApp);
        setBusy(false);
        return;
      }
    }

    await _dialogService.showDialog(
      title: 'Dados alterados com sucesso',
      description: 'Seu perfil foi atualizado',
    );

    //atualiza user em memória
    userApp = await (_userRepository.getUser(userApp!.uid));
    _userService.setUserApp(userApp);
    setBusy(false);


  }

  // @action
  // Future signUp({
  //   @required String email,
  //   @required String password,
  //   @required String name,
  // }) async {
  //   //loading = true;
  //   try {
  //     var _firebaseUser = await _authenticationService.signUpwithEmailPassword(email,password
  //       // email: email,
  //       // password: password,
  //       // fullName: name,
  //     );
  //     //loading = false;

  //     if (_firebaseUser != null) {
  //       // create a new user profile on firestore
  //       var _currentUser = User(
  //         uid: _firebaseUser.uid,
  //         email: email,
  //         fullName: name,
  //       );

  //       await _userRepository.createUser(_currentUser);
  //       await _userService.populateCurrentUser(_firebaseUser);
  //       await Modular.to.pushReplacementNamed('/'); // Va

  //     } else {
  //       await _dialogService.showDialog(
  //         title: 'Erro no cadastro',
  //         description:
  //             'Erro geral no cadastramento. Por favor tente novamente mais tarde',
  //       );
  //     }
  //   } catch (e) {
  //     await _dialogService.showDialog(
  //       title: 'Erro no cadastro',
  //       description: e.message,
  //     );
  //   }
  // }


}
