import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repository/draft_step_interface_repository.dart';
import '/app/modules/journey/model/step_model.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';

part 'draft_step_list_controller.g.dart';

class DraftStepListController = _DraftStepListControllerBase with _$DraftStepListController;

abstract class _DraftStepListControllerBase with Store {
  final _dialogService = Modular.get<DialogService>();
  final _draftStepRepository = Modular.get<IDraftStepRepository>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _userService = Modular.get<UserService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<StepModel>? _draftSteps;
  @observable
  List<StepModel>? _draftStepsFiltered;

  List<StepModel>? get draftSteps => _draftSteps;
  List<StepModel>? get draftStepsFiltered => _draftStepsFiltered;

  bool isListeningSteps = false;
  void init() {
    if (!isListeningSteps) listenToSteps();
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  void listenToSteps() {
    setBusy(true);
    isListeningSteps = true;
    _draftStepRepository.listenToDraftStepsRealTime().listen((StepsData) {
      List<StepModel> updatedSteps = StepsData;
      if (updatedSteps != null && updatedSteps.isNotEmpty) {
        _draftSteps = updatedSteps;
        _draftSteps!.sort((a, b) => b.date!.compareTo(a.date!));
        _draftStepsFiltered = List<StepModel>.from(_draftSteps!);
      }
      setBusy(false);
    });
    setBusy(false);
  }


  Future publishStep(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'You want to change status of this step to published?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    final draftStepId = _draftSteps![index].documentId;
    if (dialogResponse.confirmed!) {
        var result = await _draftStepRepository.publishStep(draftStepId);
        if (result is String) {
          await _dialogService.showDialog(
            title: 'Was not possible to change status of step',
            description: result,
          );
        } else {
          await _dialogService.showDialog(
            title: 'Step updated with sucess',
            description: 'Step updated to published',
          );
        }
    }
  }

  Future deleteStep(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'You want to delete this step?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed!) {
      var stepToDelete = _draftSteps![index];
      setBusy(true);
      await _draftStepRepository.deleteDraftStep(_draftStepsFiltered![index].documentId);
      await _cloudStorageService.deleteAudio(stepToDelete.inspirationFileName!);
      await _cloudStorageService.deleteAudio(stepToDelete.meditationFileName!);
      setBusy(false);
    }
  }

  void addStep() {
    Modular.to.pushNamed('/journey/draft/add');
  }

  void editStep(int index) {
    Modular.to.pushNamed('/journey/draft/edit', arguments: _draftStepsFiltered![index]);
  }

  void searchStep() {
    Modular.to.pushNamed('/journey/draft/search');
  }

  void showStepDetails(int index) {
    Modular.to.pushNamed('/journey/draft/details', arguments: _draftStepsFiltered![index]);
  }

}
