import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/user/user_app_model.dart';
import '/app/shared/services/user_service.dart';
import 'author_controller.dart';
part 'author_list_controller.g.dart';

class AuthorListController = _AuthorListControllerBase with _$AuthorListController;

abstract class _AuthorListControllerBase with Store {
  final _userService = Modular.get<UserService>();
  final _authorController = Modular.get<AuthorController>();
  
  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  String? get getUserRole =>  _userService.currentUser == null ? kRoleUser : _userService.userRole;
  String? get getUserEmail =>  _userService.currentUser == null ? 'email' : _userService.userEmail;
  bool get isUserAdmin => _userService.isUserAdmin;

  List<UserApp>? get authors => _authorController.authors;

  void editAuthor(UserApp author) {

        // o Admin pode mudar userRole
        // o author e admin podem editar campos do profile author
        Modular.to
        .pushNamed('/author/edit', arguments: author);
  }

  void showAuthorDetails(UserApp author) {
     Modular.to
        .pushNamed('/author/details', arguments: author);
    
  }

    void addAuthor() {
     Modular.to
        .pushNamed('/author/select');
    
  }



  
}