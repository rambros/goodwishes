import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'user_app_model.dart';
import 'user_repository_interface.dart';

class UserFirebaseRepository implements IUserRepository {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final StreamController<List<UserApp>> _authorController =
      StreamController<List<UserApp>>.broadcast();

  @override
  Future createUser(UserApp userApp) async {
    try {
      await _usersCollectionReference.doc(userApp.uid).set(userApp.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future getUser(String? uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      if (userData.exists == false) {
        return null;
      } else {
        return UserApp.fromData(userData.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future getUserByEmail(String? email) async {
  try {
      var refDocumentSnapshot = await _usersCollectionReference
      .where('email', isEqualTo: email )
      .get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        var tempUser = refDocumentSnapshot.docs[0];
        return  UserApp.fromData(tempUser.data() as Map<String, dynamic>);
      }
    } catch (e) {
        return null;
  }
  }

  @override
  Future updateUser(UserApp? userApp) async {
    try {
      await _usersCollectionReference.doc(userApp!.uid).set(userApp.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future updateUserName({String? userId, String? userName}) async {
    try {
      await _usersCollectionReference.doc(userId).set({'fullName': userName}, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

    @override
  Future updateUserEmail({String? userId, String? userEmail}) async {
    try {
      await _usersCollectionReference.doc(userId).set({'email': userEmail}, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future updateUserPhoto({String? userId, String? userImageUrl, String? userImageFileName}) async {
    try {
      await _usersCollectionReference.doc(userId).set({'userImageUrl': userImageUrl, 'userImageFileName': userImageFileName}, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

    @override
  Future updateUserRole({String? userId, String? userRole}) async {
    try {
      await _usersCollectionReference.doc(userId).set({'userRole': userRole}, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future deleteUser(String? uid) async {

    //delete firestore metadata of user
    var _fbUser = await _usersCollectionReference.doc(uid);
    await _fbUser.delete();


  }

  @override
    Future getListAuthorUser() async {
    try {
      var refDocumentSnapshot = await _usersCollectionReference
      .orderBy('fullName', descending: false)
      .where('userRole', whereIn: [kRoleAuthor]) //kRoleAdmin
      .get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => UserApp.fromData(snapshot.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future updateAuthor(UserApp? user, Map<String, dynamic> updateMap ) async {
    try {
      await _usersCollectionReference.doc(user!.uid).set(updateMap, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Stream listenToUsersRealTime() {
    // Register the handler for when the posts data changes
    _usersCollectionReference.snapshots().listen((userSnapshot) {
      if (userSnapshot.docs.isNotEmpty) {
        var users = userSnapshot.docs
            .map((snapshot) => UserApp.fromData(snapshot.data() as Map<String, dynamic>))
            .where((snapshot) => snapshot.userRole == 'Autor')
            .toList();

        // Add the posts onto the controller
        _authorController.add(users);
      }
    });

    return _authorController.stream;
  }
}
