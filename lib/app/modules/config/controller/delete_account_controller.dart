
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/user/user_repository_interface.dart';
import 'package:mobx/mobx.dart';

part 'delete_account_controller.g.dart';

class DeleteAccountController = _DeleteAccountControllerBase with _$DeleteAccountController;

abstract class _DeleteAccountControllerBase with Store {
    final _userService = Modular.get<UserService>();
    final _userRepository = Modular.get<IUserRepository>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  } 

  Future deleteAccount() async {

    //deletar do Firestore
    var user = _userService.currentUser!;
    var userId = user.uid;
    await _userRepository.deleteUser(userId);
    _userService.setUserApp(null);

    // delete authentication user    
    final _firebaseAuth = FirebaseAuth.instance;
    final _fbUser = _firebaseAuth.currentUser!;
    await _fbUser.delete();

    await Modular.to.pushNamed('/login');

  }
}
