import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../repository/user_journey_repository.dart';
import './../../model/models.dart';
import './../../helper/helper.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/services/dialog_service.dart';

part 'user_journey_details_controller.g.dart';

class UserJourneyDetailsController = _UserJourneyDetailsControllerBase
    with _$UserJourneyDetailsController;

abstract class _UserJourneyDetailsControllerBase with Store {
  final _userService = Modular.get<UserService>();
  final _dialogService = Modular.get<DialogService>();
  final _userJourneyRepository = Modular.get<UserJourneyRepository>();

  late UserJourney _userJourney;

  @observable
  List<UserStep> _userSteps = <UserStep>[];
  List<UserStep> get userSteps => _userSteps;

  void init(UserJourney _journey) async {
    //se data de ultimo acesso for null atualizar data de inicio e dar boas vindas
    _userJourney = _journey;
    _userSteps = _userJourney.userSteps!;
    _userSteps.sort((a, b) => a.step.stepNumber.compareTo(b.step.stepNumber));
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

  void showUserStepDetails(int index) {
    var args = UserJourneyStepArgs(userJourneyId: _userJourney.journeyId, userStep: _userSteps[index]);
    Modular.to.pushNamed('/journey/user_step/details', arguments: args);
  }

}
