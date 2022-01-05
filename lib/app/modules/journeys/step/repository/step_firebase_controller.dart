// ignore_for_file: prefer_final_fields

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/modules/journeys/model/step_model.dart';
import 'step_interface_repository.dart';

part 'step_firebase_controller.g.dart';

class StepFirebaseController = _StepFirebaseControllerBase with _$StepFirebaseController;

abstract class _StepFirebaseControllerBase with Store {
  final _stepsRepository = Modular.get<IStepRepository>();

  @observable
  var _steps = <StepModel>[];

  @observable
  var _stepsDraft = <StepModel>[];

  List<StepModel> get steps => _steps;
  List<StepModel> get stepsDraft => _stepsDraft;
  bool isListening = false;

  void init() {
    listenToSteps();
  }

  List<StepModel>? listenToSteps() {
    if (isListening == false) {
        _stepsRepository.listenToStepsRealTime().listen((stepssData) {
          List<StepModel> updatedSteps = stepssData;
          if (updatedSteps.isNotEmpty) {
            _steps = updatedSteps;
            _steps.sort((a, b) => a.title!.compareTo(b.title!));
          isListening = true;
          }
        });
    return _steps;
    };
  }

}
