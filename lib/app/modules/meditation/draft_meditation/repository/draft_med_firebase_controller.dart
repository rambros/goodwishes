import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/meditation/guided/model/meditation.dart';
import 'draft_med_interface_repository.dart';

part 'draft_med_firebase_controller.g.dart';

class DraftMeditationFirebaseController = _DraftMeditationFirebaseControllerBase with _$DraftMeditationFirebaseController;

abstract class _DraftMeditationFirebaseControllerBase with Store {
  final _draftMeditationRepository = Modular.get<IDraftMeditationRepository>();

  @observable
  List<Meditation>? _meditationsDraft;

  List<Meditation>? get meditationsDraft => _meditationsDraft;
  bool isListening = false;

  void init() {
    listenToDraftMeditations();
  }

  List<Meditation>? listenToDraftMeditations() {
    if (isListening == false) {
        _draftMeditationRepository.listenToDraftMeditationsRealTime().listen((meditationsData) {
          List<Meditation> updatedMeditations = meditationsData;
          if (updatedMeditations != null && updatedMeditations.isNotEmpty) {
            _meditationsDraft = updatedMeditations;
            _meditationsDraft!.sort((a, b) => b.date!.compareTo(a.date!));
          // _meditationsFiltered = List<Meditation>.from(_meditations);
          isListening = true;
          }
        });
    return _meditationsDraft;
    };
  }

}
