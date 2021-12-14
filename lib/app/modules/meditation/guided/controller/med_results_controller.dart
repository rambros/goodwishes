import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/meditation/guided/model/meditation.dart';
import 'package:mobx/mobx.dart';
import '/app/shared/services/dialog_service.dart';

import '../repository/med_interface_repository.dart';

part 'med_results_controller.g.dart';

class MeditationResultsController = _MeditationResultsControllerBase with _$MeditationResultsController;

abstract class _MeditationResultsControllerBase with Store {

  final _meditationRepository = Modular.get<IMeditationRepository>();
  final _dialogService = Modular.get<DialogService>();

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
  List<Meditation>? _meditations;

  List<Meditation>? get meditations => _meditations;

  void init(List<Meditation>? meditations){
    _meditations = meditations;
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
        var result = await _meditationRepository.changeToDraftStep(_meditations![index].documentId);
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


  // Future deleteMeditation(int index) async {
  //   var dialogResponse = await _dialogService.showConfirmationDialog(
  //     title: 'Você tem certeza?',
  //     description: 'Você realmente quer deletar esta Meditação?',
  //     confirmationTitle: 'Sim',
  //     cancelTitle: 'Não',
  //   );

  //   if (dialogResponse.confirmed) {
  //     var meditationToDelete = _meditations[index];
  //     setBusy(true);
  //     await _meditationRepository.deleteMeditation(_meditations[index].documentId);
  //     // Delete the image after the meditation is deleted
  //     await _cloudStorageService.deleteImage(meditationToDelete.imageFileName);
  //     setBusy(false);
  //   }
  // }

  void addMeditation() {
    Modular.to.pushNamed('/meditation/add' );
  }

  void editMeditation(int index) {
    Modular.to.pushNamed('/meditation/edit', arguments: _meditations![index] );
  }

    void searchMeditation() {
    Modular.to.pushNamed('/meditation/search' );
  }

  void showMeditationDetails(int index) {
    Modular.to.pushNamed('/meditation/details', arguments: _meditations![index] );
  }


}
