import 'user_app_model.dart';

abstract class IUserRepository {
  Future createUser(UserApp userApp);
  Future getUser(String? uid);
  Future updateUser(UserApp? userApp);
  Future updateUserPhoto({String? userId, String? userImageUrl, String? userImageFileName});
  Future updateUserRole({String? userId, String? userRole});
  Future updateUserName({String? userId, String? userName});
  Future updateUserEmail({String? userId, String? userEmail});
  Future deleteUser(String? uid);
  Stream listenToUsersRealTime();
  Future getListAuthorUser();
  Future getUserByEmail(String? email);
  Future updateAuthor(UserApp? user, Map<String, dynamic> updateMap );
}
