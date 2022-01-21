// ignore_for_file: omit_local_variable_types

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import './../../../journeys/error/failures.dart';
import './../../model/models.dart';
import 'user_journey_repository.dart';

class FirebaseUserJourneyRepository implements UserJourneyRepository {
  final _userJourneysReference = FirebaseFirestore.instance.collection('user_journeys');

  final _refsController = StreamController<List<UserJourney>>.broadcast();

  @override
  Stream listenToUserJourneys() {
    _userJourneysReference
    .snapshots()
    .listen((refsSnapshot) {
      if (refsSnapshot.docs.isNotEmpty) {
        var refs = refsSnapshot.docs
            .map((snapshot) => UserJourney.fromMap(snapshot.data()))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
        // Add the posts onto the controller
        _refsController.add(refs);
      }
    });
    return _refsController.stream;
  }

  @override
  Future<Either<Failure, UserJourney>> addUserJourney(UserJourney _userJourney) async {
    try {
      final DocumentReference newJourneyRef = _userJourneysReference.doc();
      final Map<String,dynamic> mapJourney = _userJourney.toMap();
      await newJourneyRef.set(mapJourney);
      var userJourney = UserJourney.fromMapAndUid(mapJourney, newJourneyRef.id );
      return Right(userJourney);
    } on PlatformException catch (e) {
        return Left(ServerFailure(error: e.message));
      } catch(e) {
        print (e.toString());
      return Left(ServerFailure(error: e.toString()));
    }
  }

  Future updateJourney(Journey? journey, Map<String,dynamic> updateMap) async {
    try {
      await _userJourneysReference
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
  Future updateSteps(Journey? journey, List<StepModel>? steps) async {
    var arraySteps = steps!.map((step)  {
        return step.toMap();
      }).toList();
    try {
      await _userJourneysReference
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
      await _userJourneysReference
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
