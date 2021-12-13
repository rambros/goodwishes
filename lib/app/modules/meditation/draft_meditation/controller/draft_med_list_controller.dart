import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/meditation/draft_meditation/repository/draft_med_firebase_controller.dart';
import '/app/modules/meditation/draft_meditation/repository/draft_med_interface_repository.dart';
import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';
import '/app/modules/category/category_controller.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';

part '../../guided/controller/draft_med_list_controller.g.dart';

class DraftMeditationListController = _DraftMeditationListControllerBase with _$DraftMeditationListController;

abstract class _DraftMeditationListControllerBase with Store {
  final _draftMeditationRepository = Modular.get<IDraftMeditationRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _userService = Modular.get<UserService>();
  final _categoryController = Modular.get<CategoryController>();

  final _draftMedFirebaseController = Modular.get<DraftMeditationFirebaseController>();


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

  bool? get hasCategories => _categoryController.categories == null ? null : true;

  @observable
  List<Meditation>? _draftMeditations;
  @observable
  List<Meditation>? _draftMeditationsFiltered;

  List<Meditation>? get draftMeditations => _draftMeditations;
  List<Meditation>? get draftMeditationsFiltered => _draftMeditationsFiltered;

  bool isListeningMeditations = false;
  void init() {
    //mudança para diminuir leituras 
    if (!isListeningMeditations) listenToMeditations();
    //_draftMeditations = _draftMedFirebaseController.meditationsDraft;
    //_draftMeditationsFiltered = List<Meditation>.from(_draftMeditations);
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  void listenToMeditations() {
    setBusy(true);
    isListeningMeditations = true;
    _draftMeditationRepository.listenToDraftMeditationsRealTime().listen((meditationsData) {
      List<Meditation> updatedMeditations = meditationsData;
      if (updatedMeditations != null && updatedMeditations.isNotEmpty) {
        _draftMeditations = updatedMeditations;
        _draftMeditations!.sort((a, b) => b.date!.compareTo(a.date!));
        _draftMeditationsFiltered = List<Meditation>.from(_draftMeditations!);
      }
      setBusy(false);
    });
    setBusy(false);
  }


  Future publishMeditation(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer alterar o status desta meditação para publicada?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );
    final draftMeditationId = _draftMeditations![index].documentId;
    if (dialogResponse.confirmed!) {
        var result = await _draftMeditationRepository.publishMeditation(draftMeditationId);
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

  Future deleteMeditation(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer deletar esta Meditação?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );

    if (dialogResponse.confirmed!) {
      var medToDelete = _draftMeditations![index];
      setBusy(true);
      await _draftMeditationRepository.deleteDraftMeditation(_draftMeditationsFiltered![index].documentId);
      // Delete the image file after the post is deleted
      await _cloudStorageService.deleteImage(medToDelete.imageFileName!);
      // Delete the audio file after the post is deleted
      await _cloudStorageService.deleteAudio(medToDelete.audioFileName!);
      setBusy(false);
    }
  }

  void addMeditation() {
    Modular.to.pushNamed('/meditation/draft/add');
  }

  void editMeditation(int index) {
    Modular.to.pushNamed('/meditation/draft/edit', arguments: _draftMeditationsFiltered![index]);
  }

  void searchMeditation() {
    Modular.to.pushNamed('/meditation/draft/search');
  }

  void showMeditationDetails(int index) {
    Modular.to.pushNamed('/meditation/draft/details', arguments: _draftMeditationsFiltered![index]);
  }

}
