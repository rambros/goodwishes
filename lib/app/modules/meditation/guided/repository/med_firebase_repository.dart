import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../model/meditation.dart';
import '/app/shared/comment/comment.dart';

import 'med_interface_repository.dart';

class MeditationFirebaseRepository implements IMeditationRepository {
  final _meditationsPublishedReference =
      FirebaseFirestore.instance.collection('meditations');

  final _meditationsDraftReference =
      FirebaseFirestore.instance.collection('meditations_draft');

  final _refsController = StreamController<List<Meditation>>.broadcast();

  @override
  Future getMeditationsOnceOff() async {
    try {
      var refDocumentSnapshot = await _meditationsPublishedReference.orderBy('commentDate', descending: true).get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => Meditation.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem!.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Stream listenToMeditationsRealTime() {
    // Register the handler for when the posts data changes
    _meditationsPublishedReference
    .snapshots()
    .listen((refsSnapshot) {
      if (refsSnapshot.docs.isNotEmpty) {
        var refs = refsSnapshot.docs
            .map((snapshot) => Meditation.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem!.title != null)
            .toList();

        // Add the posts onto the controller
        _refsController.add(refs);
      }
    });
    return _refsController.stream;
  }

  @override
  Future searchMeditations(String text) async {
    try {
      var refDocumentSnapshot = await _meditationsPublishedReference.get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => Meditation.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem!.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future changeToDraftMeditation(String? documentId) async {
    try {
        //get doc from published ref
        var snapshot = await _meditationsPublishedReference.doc(documentId).get();

        //copy to draft ref
        await _meditationsDraftReference.doc(documentId).set(snapshot.data()!);

        //delete from published ref
        await _meditationsPublishedReference.doc(documentId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  // Future deleteMeditation(String documentId) async {
  //   await _meditationsPublishedReference.doc(documentId).delete();
  // }

  @override
  Future updateMeditation(Meditation? ref, Map<String,dynamic> updateMap) async {
    try {
      await _meditationsPublishedReference
          .doc(ref!.documentId)
          .update(updateMap);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }


  @override
  Future deleteCategory(String? categoryValue) async {
    var refDocumentSnapshot = await _meditationsPublishedReference
        .where('category', arrayContains: categoryValue)
        .get();

    if (refDocumentSnapshot.docs.isNotEmpty) {
      var list = <String?>[];
      list.add(categoryValue);
      refDocumentSnapshot.docs.forEach((ref) => 
          _meditationsPublishedReference
          .doc(ref.id)
          .update({'category': FieldValue.arrayRemove(list)})      
       );
    }
  }

  @override
  Future updateMeditationComments(Meditation? ref, List<Comment>? listComments) async {

      //List<Comment> listComments = ref.comments;
      var arrayComments = listComments!.map((comment)  {
        return comment.toMap();
      }).toList();
    try {
      await _meditationsPublishedReference
          .doc(ref!.documentId)
          .update({'comments': FieldValue.arrayUnion(arrayComments)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future deleteMeditationComments(Meditation? ref, Comment comment) async {

      // List<Comment> listComments = comment.;
      // var arrayComments = listComments.map((comment)  {
      //   return comment.toMap();
      // }).toList();

      var  commentToDelete = <dynamic>[];
      commentToDelete.add(comment.toMap());

    try {
      await _meditationsPublishedReference
          .doc(ref!.documentId)
          .update({'comments': FieldValue.arrayRemove(commentToDelete)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future updateNumLikedMeditation(Meditation? ref) async {
      // int _numLiked;
       try {
      // if (operation == true) {_numLiked = ref.numLiked + 1;}
      // else { _numLiked = ref.numLiked - 1;}
      await _meditationsPublishedReference
          .doc(ref!.documentId)
          .update({'numLiked': ref.numLiked});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
    return null;
  }

  @override
  Future updateNumPlayedMeditation(Meditation? ref) async {
       try {
      await _meditationsPublishedReference
          .doc(ref!.documentId)
          .update({'numPlayed': ref.numPlayed});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
    return null;
  }

}
