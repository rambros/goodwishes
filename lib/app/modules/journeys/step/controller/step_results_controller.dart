import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/dialog_service.dart';
import './../../model/models.dart';
import '../repository/step_interface_repository.dart';

part 'step_results_controller.g.dart';

class StepResultsController = _StepResultsControllerBase with _$StepResultsController;

abstract class _StepResultsControllerBase with Store {

  final _stepRepository = Modular.get<IStepRepository>();
  final _dialogService = Modular.get<DialogService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<StepModel>? _steps;

  List<StepModel>? get steps => _steps;

  void init(List<StepModel>? _steps){
    _steps = _steps;
  }

  Future changeStatusToDraft(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer alterar o status desta meditação para draft?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );
    if (dialogResponse.confirmed!) {
      setBusy(true);
        var result = await _stepRepository.changeToDraftStep(_steps![index].documentId);
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
    setBusy(false);
  }


  void addStep() {
    Modular.to.pushNamed('/journey/step/add' );
  }

  void editStep(int index) {
    Modular.to.pushNamed('/journey/step/edit', arguments: _steps![index] );
  }

    void searchStep() {
    Modular.to.pushNamed('/journey/step/search' );
  }

  void showStepDetails(int index) {
    Modular.to.pushNamed('/journey/step/details', arguments: _steps![index] );
  }


}
