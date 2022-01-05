import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/journeys/model/models.dart';
import '../repository/journey_repository.dart';
import '../../journey/helper/helper.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';

part 'journey_details_controller.g.dart';

class JourneyDetailsController = _JourneyDetailsControllerBase
    with _$JourneyDetailsController;

abstract class _JourneyDetailsControllerBase with Store {
  final _userService = Modular.get<UserService>();
  final _dialogService = Modular.get<DialogService>();
  final _journeyRepository = Modular.get<JourneyRepository>();

  late Journey _journey;

  @observable
  List<StepModel> _steps = <StepModel>[];
  List<StepModel> get steps => _steps;

  void init(Journey journey) async {
    _journey = journey;
    _steps = journey.steps!;
    _steps.sort((a, b) => a.stepNumber.compareTo(b.stepNumber));
  }

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  String? get getUserRole =>
    _userService.currentUser == null ? 'user' : _userService.userRole;

  Future deleteStep(StepModel step) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'You want to delete this step?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    if (dialogResponse.confirmed!) {
      setBusy(true);
      //delete from list
      _steps.removeWhere(((item) => step.hashCode == item.hashCode));
      //update Journey
      _journey.steps = _steps;
      //update repository
      var result = await _journeyRepository.deleteStep(journeyId: _journey.journeyId!, step: step);
      if (result is String) {
        await _dialogService.showDialog(
          title: 'Was not possible to delete Step',
          description: result,
        );
      }
      setBusy(false);
    }
  }

  void addStep() {
    var args = JourneyStepArgs(journeyId: _journey.journeyId!, );
    Modular.to.pushNamed('/journey/step/add', arguments: args);
  }

  void editStep(int index) {
    var args = JourneyStepArgs(journeyId: _journey.journeyId!, step: _steps[index]);
    Modular.to.pushNamed('/journey/step/edit', arguments: args);
  }

  void showStepDetails(int index) {
    var args = JourneyStepArgs(journeyId: _journey.journeyId!, step: _steps[index]);
    Modular.to.pushNamed('/journey/step/details', arguments: args);
  }
}

