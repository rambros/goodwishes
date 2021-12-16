import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/dialog_service.dart';
import '/app/modules/journey/model/step_model.dart';
import '../repository/step_interface_repository.dart';

part 'step_edit_controller.g.dart';

class StepEditController = _StepEditControllerBase with _$StepEditController;

abstract class _StepEditControllerBase with Store {
  final _stepRepository = Modular.get<IStepRepository>();
  final _dialogService = Modular.get<DialogService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  void init() {
  }

  StepModel? _edittingStep;

  @action
  Future editStep({
      required String title,
      int? stepNumber,
      String? descriptionText,
      String? inspirationText,
      String? meditationText,
      String? practiceText,
      }) async {
    setBusy(true);
    var result;
    final updateMap = {
      'title': title,
      'descriptionText': descriptionText,
      'stepNumber': stepNumber,
      'inspirationText': inspirationText,
      'meditationText': meditationText,
      'practiceText': practiceText,
    };
    result = await _stepRepository.updateStep(_edittingStep, updateMap);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Was not possible to update this Step',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Step updated with success',
        description: 'Step updated.',
      );
    }
    Modular.to.pop();
  }

  void setEdittingStep(StepModel? edittingStep) {
    _edittingStep = edittingStep;
  }

}
