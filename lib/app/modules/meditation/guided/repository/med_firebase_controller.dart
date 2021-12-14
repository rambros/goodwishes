// ignore_for_file: prefer_final_fields

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../model/meditation.dart';
import 'med_interface_repository.dart';

part 'med_firebase_controller.g.dart';

class MeditationFirebaseController = _MeditationFirebaseControllerBase with _$MeditationFirebaseController;

abstract class _MeditationFirebaseControllerBase with Store {
  final _meditationRepository = Modular.get<IMeditationRepository>();

  @observable
  var _meditations = <Meditation>[];

  @observable
  var _meditationsDraft = <Meditation>[];

  List<Meditation> get meditations => _meditations;
  List<Meditation> get meditationsDraft => _meditationsDraft;
  bool isListening = false;

  void init() {
    listenToMeditations();
  }

  List<Meditation>? listenToMeditations() {
    if (isListening == false) {
        _meditationRepository.listenToMeditationsRealTime().listen((meditationsData) {
          List<Meditation> updatedMeditations = meditationsData;
          if (updatedMeditations != null && updatedMeditations.isNotEmpty) {
            _meditations = updatedMeditations;
            _meditations.sort((a, b) => b.date!.compareTo(a.date!));
          // _meditationsFiltered = List<Meditation>.from(_meditations);
          isListening = true;
          }
        });
    return _meditations;
    };
  }

}
