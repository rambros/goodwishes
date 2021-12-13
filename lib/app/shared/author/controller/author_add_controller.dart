import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/services/dialog_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/user/user_repository_interface.dart';

part 'author_add_controller.g.dart';

class AuthorAddController = _AuthorAddControllerBase with _$AuthorAddController;

abstract class _AuthorAddControllerBase with Store {
  final _userRepository = Modular.get<IUserRepository>();
  final _dialogService = Modular.get<DialogService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  void init() {}

  @observable
  UserApp? author;

  @computed
  bool get isAuthorSelected => author != null? true : false;

  @action
  void clearUser() => author = null;

  @action
  Future changeUserRole(String? newUserRole) async {
    print ( newUserRole);
    var result = await _userRepository.updateUserRole(userId: author!.uid, userRole: newUserRole );
    
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel adicionar o Autor',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Perfil alterado com sucesso',
        description: 'Os dados foram alterados',
      );
      author = await (_userRepository.getUser(author!.uid));
    }
  } 

  Future selectAuthor({
    required String? email,
  }) async {
    setBusy(true);
    author = await (_userRepository.getUserByEmail( email ));

    setBusy(false);

    if (author == null ) {
      await _dialogService.showDialog(
        title: 'Não foi possivel selecionar o Autor',
        description: 'Email inexistente',
      );
      return;
    }


  }





  Future addAuthor({
    required String? curriculum,
    String? contact,
    String? site,
  }) async {
    setBusy(true);

    var result;

    // está editando Authorlexão
    var updateMap = {
      'curriculum': curriculum,
      'site': site,
      'contact': contact,
    };

    result = await _userRepository.updateAuthor(author, updateMap);

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel adicionar o Autor',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Autor adicionado com sucesso',
        description: 'Os dados foram adicionados',
      );
    }

    Modular.to.pop();
  }
}
