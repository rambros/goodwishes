import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../model/timer_music_model.dart';

class TimerMusicRepository {
  final _TimerMusicsCollectionReference =
      FirebaseFirestore.instance.collection('TimerMusics');

  final _tmController = StreamController<List<TimerMusic?>>.broadcast();

  Future addTimerMusic(TimerMusic timerMusic) async {
    try {
      await _TimerMusicsCollectionReference.add(timerMusic.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getTimerMusicsOnceOff() async {
    try {
      var tmDocumentSnapshot = await _TimerMusicsCollectionReference.orderBy(
              'title',
              descending: false)
          .get();
      if (tmDocumentSnapshot.docs.isNotEmpty) {
        return tmDocumentSnapshot.docs
            .map((snapshot) =>
                TimerMusic.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToTimerMusicsRealTime() {
    // Register the handler for when the posts data changes
    _TimerMusicsCollectionReference.snapshots().listen((tmSnapshot) {
      if (tmSnapshot.docs.isNotEmpty) {
        var refs = tmSnapshot.docs
            .map((snapshot) =>
                TimerMusic.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();

        // Add the posts onto the controller
        _tmController.add(refs);
      }
    });

    return _tmController.stream;
  }

  Future searchTimerMusics(String text) async {
    try {
      var tmDocumentSnapshot =
          await _TimerMusicsCollectionReference.get();
      if (tmDocumentSnapshot.docs.isNotEmpty) {
        return tmDocumentSnapshot.docs
            .map((snapshot) =>
                TimerMusic.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future deleteTimerMusic(String? documentId) async {
    await _TimerMusicsCollectionReference.doc(documentId).delete();
  }

  Future updateTimerMusic(TimerMusic tm, Map<String, dynamic> updateMap) async {
    try {
      await _TimerMusicsCollectionReference.doc(tm.documentId)
          .update(updateMap);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
