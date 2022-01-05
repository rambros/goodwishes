
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/services/dialog_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/user/user_repository_interface.dart';

part 'author_edit_controller.g.dart';

class AuthorEditController = _AuthorEditControllerBase with _$AuthorEditController;

abstract class _AuthorEditControllerBase with Store {
  final _userRepository = Modular.get<IUserRepository>();
  final _dialogService = Modular.get<DialogService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  void init() {
  }


  UserApp? _edittingAuthor;

  Future editAuthor({
      required String? curriculum,
      String? contact,
      String? site,}) async {
    setBusy(true);

    var result;

    // está editando Author
    var updateMap = {
      'curriculum': curriculum,
      'site': site,
      'contact': contact, 
    };

    result = await _userRepository.updateAuthor(_edittingAuthor, updateMap);

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel atualizar o Autor',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Autor atualizado com sucesso',
        description: 'Os dados foram atualizados',
      );
    }

    Modular.to.pop();
  }

  void setEdittingAuthor(UserApp? edittingAuthor) {
    _edittingAuthor = edittingAuthor;
  }

}
