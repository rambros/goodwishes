import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/app/modules/journeys/model/step_model.dart';
import '/app/shared/comment/comment.dart';
import 'step_interface_repository.dart';

class StepFirebaseRepository implements IStepRepository {
  final _stepsPublishedReference =
      FirebaseFirestore.instance.collection('steps');

  final _stepsDraftReference =
      FirebaseFirestore.instance.collection('steps_draft');

  final _refsController = StreamController<List<StepModel>>.broadcast();

  @override
  Future getStepsOnceOff() async {
    try {
      var refDocumentSnapshot = await _stepsPublishedReference.orderBy('commentDate', descending: true).get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => StepModel.fromMap(snapshot.data()))
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
  Stream listenToStepsRealTime() {
    _stepsPublishedReference
    .snapshots()
    .listen((refsSnapshot) {
      if (refsSnapshot.docs.isNotEmpty) {
        var refs = refsSnapshot.docs
            .map((snapshot) => StepModel.fromMap(snapshot.data()))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
        // Add the posts onto the controller
        _refsController.add(refs);
      }
    });
    return _refsController.stream;
  }

  @override
  Future searchSteps(String text) async {
    try {
      var refDocumentSnapshot = await _stepsPublishedReference.get();
      if (refDocumentSnapshot.docs.isNotEmpty) {
        return refDocumentSnapshot.docs
            .map((snapshot) => StepModel.fromMap(snapshot.data()))
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
  Future changeToDraftStep(String? documentId) async {
    try {
        //get doc from published ref
        var snapshot = await _stepsPublishedReference.doc(documentId).get();

        //copy to draft ref
        await _stepsDraftReference.doc(documentId).set(snapshot.data()!);

        //delete from published ref
        await _stepsPublishedReference.doc(documentId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future updateStep(StepModel? ref, Map<String,dynamic> updateMap) async {
    try {
      await _stepsPublishedReference
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
  Future updateStepComments(StepModel? ref, List<Comment>? listComments) async {

      //List<Comment> listComments = ref.comments;
      var arrayComments = listComments!.map((comment)  {
        return comment.toMap();
      }).toList();
    try {
      await _stepsPublishedReference
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
  Future deleteStepComments(StepModel? ref, Comment comment) async {

      // List<Comment> listComments = comment.;
      // var arrayComments = listComments.map((comment)  {
      //   return comment.toMap();
      // }).toList();

      var  commentToDelete = <dynamic>[];
      commentToDelete.add(comment.toMap());

    try {
      await _stepsPublishedReference
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
  Future updateNumLikedStep(StepModel? ref) async {
      // int _numLiked;
       try {
      // if (operation == true) {_numLiked = ref.numLiked + 1;}
      // else { _numLiked = ref.numLiked - 1;}
      await _stepsPublishedReference
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
  Future updateNumPlayedStep(StepModel? ref) async {
       try {
      await _stepsPublishedReference
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
