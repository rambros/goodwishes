import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './../../model/models.dart';
import '../repository/journey_repository.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';

part 'journey_list_controller.g.dart';

class JourneyListController = _JourneyListControllerBase with _$JourneyListController;

abstract class _JourneyListControllerBase with Store {
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _journeyRepository = Modular.get<JourneyRepository>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<Journey>? _journeys;
  //@observable
  //List<Journey>? _journeysFiltered;

  List<Journey>? get journeys => _journeys;
  //List<Journey>? get journeysFiltered => _journeysFiltered;

  bool isListeningJourneys = false;
  void init() {
    if (!isListeningJourneys) listenToJourneys();
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  void listenToJourneys() {
    setBusy(true);
    isListeningJourneys = true;
    _journeyRepository.listenToJourneys().listen((journeyData) {
      List<Journey> updatedJourneys = journeyData;
      if (updatedJourneys != null && updatedJourneys.isNotEmpty) {
        _journeys = updatedJourneys;
        _journeys!.sort((a, b) => b.title!.compareTo(a.title!));
        //_journeysFiltered = List<Journey>.from(_journeys!);
      }
      setBusy(false);
    });
    setBusy(false);
  }

  Future deleteJourney(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'You want to delete this journey?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed!) {
      var journeyToDelete = _journeys![index];
      setBusy(true);
      await _journeyRepository.deleteJourney(_journeys![index].journeyId);
      //delete steps ?
      setBusy(false);
    }
  }

  void addJourney() {
    Modular.to.pushNamed('/journey/add');
  }

  void editJourney(int index) {
    Modular.to.pushNamed('/journey/edit', arguments: _journeys![index]);
  }

  void showJourneyDetails(int index) {
    Modular.to.pushNamed('/journey/details', arguments: _journeys![index]);
  }

}
