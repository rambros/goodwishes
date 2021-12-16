import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/services/user_service.dart';
import '../../../../shared/services/dialog_service.dart';
import '/app/modules/journey/model/step_model.dart';
import '../repository/step_firebase_controller.dart';
import '../repository/step_interface_repository.dart';

part 'step_list_controller.g.dart';

class StepListController = _StepListControllerBase with _$StepListController;

abstract class _StepListControllerBase with Store {
  final _stepRepository = Modular.get<IStepRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _stepFirebaseController = Modular.get<StepFirebaseController>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<StepModel> _steps = <StepModel>[];
  @observable
  List<StepModel> _stepsFiltered = <StepModel>[];

  List<StepModel> get steps => _steps;
  List<StepModel> get stepsFiltered => _stepsFiltered;

  bool isListeningsteps = false;
  void init() {
    _steps = _stepFirebaseController.steps;
    _stepsFiltered = List<StepModel>.from(_steps);
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  Future changeStatusToDraft(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'You want to change status of this step to draft?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    if (dialogResponse.confirmed!) {
      setBusy(true);
        var result = await _stepRepository.changeToDraftStep(_stepsFiltered[index].documentId);
        if (result is String) {
          await _dialogService.showDialog(
            title: 'Was not possible to change status of step',
            description: result,
          );
        } else {
          await _dialogService.showDialog(
            title: 'Step updated with sucess',
            description: 'Step updated to draft',
          );
        }
    }
    setBusy(false);
  }

 
  void addStep() {
    Modular.to.pushNamed('/journey/add');
  }

  void editStep(int index) {
    Modular.to.pushNamed('/journey/edit', arguments: _stepsFiltered[index]);
  }

  void searchStep() {
    Modular.to.pushNamed('/journey/search');
  }

  void showStepDetails(int index) {
    Modular.to.pushNamed('/journey/details', arguments: _stepsFiltered[index]);
  }

}
