import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/dialog_service.dart';

part 'forget_password_controller.g.dart';

class ForgetPasswordController = _ForgetPasswordControllerBase with _$ForgetPasswordController;

abstract class _ForgetPasswordControllerBase with Store {
  final _dialogService = Modular.get<DialogService>();

  
  Future<void> resetPassword(String email) async {
    final auth = FirebaseAuth.instance; 

    try{
      await auth.sendPasswordResetEmail(email: email);
      await _dialogService.showDialog(
        title: 'Redefinição de senha',
        description: 'Um email foi enviado para $email. \n\nClique naquele link & redefina sua senha.',
      );
    } on FirebaseAuthException catch(error){
        var msgError;
        switch ( error.code) {
            case 'ERROR_USER_NOT_FOUND' : msgError = 'Usuário não encontrado';
                    break;
            case 'ERROR_INVALID_EMAIL' : msgError = 'Email inválido';
                    break;
            default: msgError = error.code;
          }
        await _dialogService.showDialog(
          title: 'Ocorreu um erro na redefição da senha',
          description: msgError
      ); 
    };
    //Future.delayed(Duration(milliseconds: 1000)).then((f) {
     await Modular.to.pushNamed('/login/signin'); 
    //});

  }
  
}