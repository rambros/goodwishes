import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../user/user_app_model.dart';
import '../user/user_repository_interface.dart';

part 'user_service.g.dart';

class UserService = _UserServiceBase with _$UserService;

abstract class _UserServiceBase with Store {

  final _userRepository = Modular.get<IUserRepository>();

 // @observable
  UserApp? _currentUser;
  UserApp? get currentUser => _currentUser;
  String? get userRole => _currentUser!.userRole;
  String? get userEmail => _currentUser!.email;
  bool get isUserAdmin => userRole == kRoleAdmin ? true : false;

  String? get name => _currentUser!.fullName;
  String? get uid => _currentUser!.uid;
  String? get email => _currentUser!.email;
  String get imageUrl => _currentUser!.userImageUrl ?? '';



  @action
  void setUserApp(UserApp? userApp) {
    _currentUser = userApp;
  }

  void changeFavorite({String? docId, required bool addFavorite}) {
    if (addFavorite) {
      _currentUser!.favorites!.add(docId);
      _userRepository.updateUser(_currentUser);
    } else {
      _currentUser!.favorites!.remove(docId);
      _userRepository.updateUser(_currentUser);
    }
  }



  Future populateCurrentUser(User? _firebaseUser) async {
    if (_firebaseUser != null) {
      UserApp? _currentUser = await _userRepository.getUser(_firebaseUser.uid);
      if (_currentUser is UserApp) { 
          setUserApp(_currentUser);
      };
      // else {
      //   logout();
      // }
    }
  }


  Future updateUserName( String userName) async {
    var result = await _userRepository.updateUserName(userId:_currentUser!.uid, userName: userName);
    return result;
  }

  Future updateUserEmail( String userEmail) async {
    var result = await _userRepository.updateUserEmail(userId:_currentUser!.uid, userEmail: userEmail);
    return result;
  }

  Future createUser(User _firebaseUser) async {
    var _currentUser = UserApp(
          uid: _firebaseUser.uid,
          loginType: 'Google',
          email: _firebaseUser.email,
          fullName: _firebaseUser.displayName,
          userImageUrl: _firebaseUser.photoURL,
    );
    await _userRepository.createUser(_currentUser);
    
  }

  Future<UserApp?> getUserApp(String uid) async {
    var userApp = await _userRepository.getUser(uid);
    return userApp;
  }


  Future<bool> checkUserExists(User? firebaseUser) async {
      if (firebaseUser == null)  {
         return false; 
      }
      var uid = firebaseUser.uid;
      var result = await getUserApp(uid);
      if (result is UserApp) {
        return true;
      } else {
        return false;
      }
  }

}