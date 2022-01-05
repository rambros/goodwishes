import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import './../../model/models.dart';
import 'journey_repository.dart';

class FirebaseJourneyRepository implements JourneyRepository {
  final _journeysReference = FirebaseFirestore.instance.collection('journeys');

  final _refsController = StreamController<List<Journey>>.broadcast();

  @override
  Stream listenToJourneys() {
    _journeysReference
    .snapshots()
    .listen((refsSnapshot) {
      if (refsSnapshot.docs.isNotEmpty) {
        var refs = refsSnapshot.docs
            .map((snapshot) => Journey.fromMap(snapshot.data(),snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
        // Add the posts onto the controller
        _refsController.add(refs);
      }
    });
    return _refsController.stream;
  }

  @override
  Future addJourney(Journey journey) async {
    try {
      await _journeysReference.add(journey.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future deleteJourney(String? journeyId) async {
    await _journeysReference.doc(journeyId).delete();
  }

  @override
  Future updateJourney(Journey? journey, Map<String,dynamic> updateMap) async {
    try {
      await _journeysReference
          .doc(journey!.journeyId)
          .update(updateMap);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }


  /// Steps  ///
  @override
  Future addStep({required String journeyId, required StepModel step}) async {
    var stepToAdd = <dynamic>[];
    stepToAdd.add(step.toMap());
    try {
      await _journeysReference
          .doc(journeyId)
          .update({'steps': FieldValue.arrayUnion(stepToAdd)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future deleteStep({required String journeyId, required StepModel step}) async {
    var stepToDelete = <dynamic>[];
    stepToDelete.add(step.toMap());
    try {
      await _journeysReference
          .doc(journeyId)
          .update({'steps': FieldValue.arrayRemove(stepToDelete)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future updateSteps(Journey? journey, List<StepModel>? steps) async {
    var arraySteps = steps!.map((step)  {
        return step.toMap();
      }).toList();
    try {
      await _journeysReference
          .doc(journey!.journeyId)
          .update({'steps': FieldValue.arrayUnion(arraySteps)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  @override
  Future updateStep({required String journeyId, required StepModel step}) async {
    var stepToUpdate = <dynamic>[];
    stepToUpdate.add(step.toMap());
    try {
      await _journeysReference
          .doc(journeyId)
          .update({'steps': FieldValue.arrayUnion(stepToUpdate)});
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
