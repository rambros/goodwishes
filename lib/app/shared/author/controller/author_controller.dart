import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/user/user_app_model.dart';
import '/app/shared/user/user_repository_interface.dart';
part 'author_controller.g.dart';

class AuthorController = _AuthorControllerBase with _$AuthorController;

abstract class _AuthorControllerBase with Store {
  final _userRepository = Modular.get<IUserRepository>();
  
  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }
  @observable
  List<UserApp>? _listAuthors;

  List<UserApp>? get authors => _listAuthors;

  Future<List<UserApp>?> getListAuthors() async {
    return await (_userRepository.getListAuthorUser());
  }

  Future<String?> getAuthorName(String? userId) async {
     UserApp author = await (_userRepository.getUser(userId));
     return author.fullName;
  }

  Future<UserApp?> getAuthorById( String? userId) async {
     UserApp? _author = await (_userRepository.getUser(userId));
     return _author;
  }

  void listenToAuthors() {
    _userRepository.listenToUsersRealTime().listen((usersData) {
      List<UserApp>? updatedAuthors = usersData;
      if (updatedAuthors != null && updatedAuthors.isNotEmpty) {
        _listAuthors = updatedAuthors;
      }
    });
  }

   void getListAuthorsOnce() async {
       _listAuthors = await (_userRepository.getListAuthorUser());
  }

}