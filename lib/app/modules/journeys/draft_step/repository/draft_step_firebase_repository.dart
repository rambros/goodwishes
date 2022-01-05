import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '/app/modules/journeys/model/step_model.dart';
import '/app/shared/comment/comment.dart';
import 'draft_step_interface_repository.dart';

class DraftStepFirebaseRepository implements IDraftStepRepository {
  final CollectionReference _stepsDraftReference =
      FirebaseFirestore.instance.collection('steps_draft');

  final CollectionReference _stepsPublishedReference =
      FirebaseFirestore.instance.collection('steps');

  final StreamController<List<StepModel?>> _refsController =
      StreamController<List<StepModel>>.broadcast();

  @override
  Future addDraftStep(StepModel ref) async {
    try {
      await _stepsDraftReference.add(ref.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future publishStep(String? documentId) async {
    try {
        //get doc from draft ref
        var snapshot = await _stepsDraftReference.doc(documentId).get();

        //copy to published ref
        await _stepsPublishedReference.doc(documentId).set(snapshot.data());

        //delete from draft ref
        await _stepsDraftReference.doc(documentId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future getDraftStepsOnceOff() async {
    try {
      var refDocumentSnapshot = await _stepsDraftReference.orderBy('commentDate', descending: true).get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => StepModel.fromMap(snapshot.data() as Map<String, dynamic>))
            .where((mappedItem) => mappedItem.title != null)
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
  Stream listenToDraftStepsRealTime() {
    _stepsDraftReference
    .snapshots()
    .listen((refsSnapshot) {
      if (refsSnapshot.docs.isNotEmpty) {
        var refs = refsSnapshot.docs
            .map((snapshot) => StepModel.fromMap(snapshot.data() as Map<String, dynamic>))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
        // Add the posts onto the controller
        _refsController.add(refs);
      }
    });
    return _refsController.stream;
  }

  @override
  Future searchDraftSteps(String text) async {
    try {
      var refDocumentSnapshot = await _stepsDraftReference.get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => StepModel.fromMap(snapshot.data() as Map<String, dynamic>))
            .where((mappedItem) => mappedItem.title != null)
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
  Future deleteDraftStep(String? documentId) async {
    await _stepsDraftReference.doc(documentId).delete();
  }

  @override
  Future updateDraftStep(StepModel? ref, Map<String,dynamic> updateMap) async {
    try {
      await _stepsDraftReference
          .doc(ref!.documentId)
          .update(updateMap);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future updateStepComments(StepModel ref, List<Comment> listComments) async {
    var arrayComments = listComments.map((comment)  {
        return comment.toMap();
      }).toList();
    try {
      await _stepsDraftReference
          .doc(ref.documentId)
          .update({'comments': FieldValue.arrayUnion(arrayComments)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future deleteStepComments(StepModel ref, Comment comment) async {
    var commentToDelete = <dynamic>[];
    commentToDelete.add(comment.toMap());
    try {
      await _stepsDraftReference
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
