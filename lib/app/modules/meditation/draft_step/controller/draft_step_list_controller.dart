import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../repository/draft_step_firebase_controller.dart';
import '../repository/draft_step_interface_repository.dart';
import '/app/modules/meditation/guided/model/step_model.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';

part 'draft_step_list_controller.g.dart';

class DraftStepListController = _DraftStepListControllerBase with _$DraftStepListController;

abstract class _DraftStepListControllerBase with Store {
  final _DraftStepRepository = Modular.get<IDraftStepRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _userService = Modular.get<UserService>();

  final _draftStepFirebaseController = Modular.get<DraftStepFirebaseController>();


  // String get getUserRole => _authenticationService.status == AuthenticationStatus.loggedIn
  //                            ?  _authenticationService.currentUser
  //                            : "not logged";

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<StepModel>? _DraftSteps;
  @observable
  List<StepModel>? _DraftStepsFiltered;

  List<StepModel>? get DraftSteps => _DraftSteps;
  List<StepModel>? get DraftStepsFiltered => _DraftStepsFiltered;

  bool isListeningSteps = false;
  void init() {
    if (!isListeningSteps) listenToSteps();
    //_DraftSteps = _draftStepFirebaseController.StepsDraft;
    //_DraftStepsFiltered = List<Meditation>.from(_DraftSteps);
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  void listenToSteps() {
    setBusy(true);
    isListeningSteps = true;
    _DraftStepRepository.listenToDraftStepsRealTime().listen((StepsData) {
      List<StepModel> updatedSteps = StepsData;
      if (updatedSteps != null && updatedSteps.isNotEmpty) {
        _DraftSteps = updatedSteps;
        _DraftSteps!.sort((a, b) => b.date!.compareTo(a.date!));
        _DraftStepsFiltered = List<StepModel>.from(_DraftSteps!);
      }
      setBusy(false);
    });
    setBusy(false);
  }


  Future publishStep(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'Você realmente quer alterar o status desta meditação para publicada?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    final DraftStepId = _DraftSteps![index].documentId;
    if (dialogResponse.confirmed!) {
        var result = await _DraftStepRepository.publishStep(DraftStepId);
        if (result is String) {
          await _dialogService.showDialog(
            title: 'Não foi possivel mudar o status da meditação',
            description: result,
          );
        } else {
          await _dialogService.showDialog(
            title: 'Meditação alterada com sucesso',
            description: 'Meditação alterada para draft',
          );
        }
    }
  }

  Future deleteStep(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer deletar esta Meditação?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );

    if (dialogResponse.confirmed!) {
      var medToDelete = _DraftSteps![index];
      setBusy(true);
      await _DraftStepRepository.deleteDraftStep(_DraftStepsFiltered![index].documentId);
      // Delete the audio file after the post is deleted
      await _cloudStorageService.deleteAudio(medToDelete.audioFileName!);
      setBusy(false);
    }
  }

  void addStep() {
    Modular.to.pushNamed('/meditation/draft/add');
  }

  void editStep(int index) {
    Modular.to.pushNamed('/meditation/draft/edit', arguments: _DraftStepsFiltered![index]);
  }

  void searchStep() {
    Modular.to.pushNamed('/meditation/draft/search');
  }

  void showStepDetails(int index) {
    Modular.to.pushNamed('/meditation/draft/details', arguments: _DraftStepsFiltered![index]);
  }

}
