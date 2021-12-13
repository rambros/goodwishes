import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/comment/comment.dart';

import 'draft_med_interface_repository.dart';

class DraftMeditationFirebaseRepository implements IDraftMeditationRepository {
  final CollectionReference _meditationsDraftReference =
      FirebaseFirestore.instance.collection('meditations_draft');

  final CollectionReference _meditationsPublishedReference =
      FirebaseFirestore.instance.collection('meditations');

  final StreamController<List<Meditation?>> _refsController =
      StreamController<List<Meditation>>.broadcast();

  @override
  Future addDraftMeditation(Meditation ref) async {
    try {
      await _meditationsDraftReference.add(ref.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future publishMeditation(String? documentId) async {
    try {
        //get doc from draft ref
        var snapshot = await _meditationsDraftReference.doc(documentId).get();

        //copy to published ref
        await _meditationsPublishedReference.doc(documentId).set(snapshot.data());

        //delete from draft ref
        await _meditationsDraftReference.doc(documentId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future getDraftMeditationsOnceOff() async {
    try {
      var refDocumentSnapshot = await _meditationsDraftReference.orderBy('commentDate', descending: true).get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => Meditation.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id))
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
  Stream listenToDraftMeditationsRealTime() {
    // Register the handler for when the posts data changes
    _meditationsDraftReference
    .snapshots()
    .listen((refsSnapshot) {
      if (refsSnapshot.docs.isNotEmpty) {
        var refs = refsSnapshot.docs
            .map((snapshot) => Meditation.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem!.title != null)
            .toList();

        // Add the posts onto the controller
        _refsController.add(refs);
      }
    });

    return _refsController.stream;
  }

  @override
  Future searchDraftMeditations(String text) async {
    try {
      var refDocumentSnapshot = await _meditationsDraftReference.get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => Meditation.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id))
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
  Future deleteDraftMeditation(String? documentId) async {
    await _meditationsDraftReference.doc(documentId).delete();
  }

  @override
  Future updateDraftMeditation(Meditation? ref, Map<String,dynamic> updateMap) async {
    try {
      await _meditationsDraftReference
          .doc(ref!.documentId)
          .update(updateMap);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }


  
  Future deleteCategory(String categoryValue) async {
    var refDocumentSnapshot = await _meditationsDraftReference
        .where('category', arrayContains: categoryValue)
        .get();

    if (refDocumentSnapshot.docs.isNotEmpty) {
      var list = <String>[];
      list.add(categoryValue);
      refDocumentSnapshot.docs.forEach((ref) => 
          _meditationsDraftReference
          .doc(ref.id)
          .update({'category': FieldValue.arrayRemove(list)})      
       );
    }
  }

  Future updateMeditationComments(Meditation ref, List<Comment> listComments) async {
    var arrayComments = listComments.map((comment)  {
        return comment.toMap();
      }).toList();
    try {
      await _meditationsDraftReference
          .doc(ref.documentId)
          .update({'comments': FieldValue.arrayUnion(arrayComments)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future deleteMeditationComments(Meditation ref, Comment comment) async {
    var commentToDelete = <dynamic>[];
    commentToDelete.add(comment.toMap());
    try {
      await _meditationsDraftReference
          .doc(ref.documentId)
          .update({'comments': FieldValue.arrayRemove(commentToDelete)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
