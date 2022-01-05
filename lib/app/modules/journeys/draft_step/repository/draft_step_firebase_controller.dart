import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/journeys/model/step_model.dart';
import 'draft_step_interface_repository.dart';

part 'draft_step_firebase_controller.g.dart';

class DraftStepFirebaseController = _DraftStepFirebaseControllerBase with _$DraftStepFirebaseController;

abstract class _DraftStepFirebaseControllerBase with Store {
  final _draftStepRepository = Modular.get<IDraftStepRepository>();

  @observable
  List<StepModel>? _stepsDraft;

  List<StepModel>? get stepsDraft => _stepsDraft;
  bool isListening = false;

  void init() {
    listenToDraftSteps();
  }

  List<StepModel>? listenToDraftSteps() {
    if (isListening == false) {
        _draftStepRepository.listenToDraftStepsRealTime().listen((StepsData) {
          List<StepModel> updatedSteps = StepsData;
          if (updatedSteps != null && updatedSteps.isNotEmpty) {
            _stepsDraft = updatedSteps;
            _stepsDraft!.sort((a, b) => b.date!.compareTo(a.date!));
          isListening = true;
          }
        });
    return _stepsDraft;
    };
  }

}
