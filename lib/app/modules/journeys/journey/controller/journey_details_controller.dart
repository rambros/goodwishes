import 'package:dartz/dartz.dart';
import 'package:goodwishes/app/modules/journeys/error/failures.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/journeys/model/models.dart';
import '/app/modules/journeys/helper/helper.dart';
import '/app/modules/journeys/user_journey/repository/user_journey_repository.dart';
import '../repository/journey_repository.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';

part 'journey_details_controller.g.dart';

class JourneyDetailsController = _JourneyDetailsControllerBase
    with _$JourneyDetailsController;

abstract class _JourneyDetailsControllerBase with Store {
  final _userService = Modular.get<UserService>();
  final _dialogService = Modular.get<DialogService>();
  final _journeyRepository = Modular.get<JourneyRepository>();
  final _userJourneyRepository = Modular.get<UserJourneyRepository>();

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

  UserStep _userStepFromStep(StepModel step) {
    return UserStep(
      step: step,
      status: 'closed',
      dateStarted: null,
      dateCompleted: null,
    );
  }

  @action
  Future startUserJourney(Journey journey) async {
    setBusy(true);
    
    var _userJourneyResult = await _userJourneyRepository.addUserJourney(
      UserJourney(
        userId: _userService.uid!,
        journeyId: journey.journeyId!,
        title: journey.title,
        description: journey.description,
        imageFileName: journey.imageFileName,
        imageUrl: journey.imageUrl,
        dateStarted: DateTime.now(),
        dateCompleted: null,
        lastAccessDate: null,
        stepsCompleted: 0,
        stepsTotal: journey.stepsTotal,
        userSteps: List<UserStep>.from(journey.steps!.map((x) => _userStepFromStep(x))),
        status: 'ongoing',
      )
    );

    setBusy(false);

    await _userJourneyResult.fold(
      (failureResult) async {
        String? message;
        if(failureResult is ServerFailure) {
          message = failureResult.error;
        }else {
          message = 'Unexpected error';
        };
        await _dialogService.showDialog(
          title: 'Was not possible to start this Journey',
          description: message,
        );
      }, 
      (userJourney) {
        Modular.to.popAndPushNamed('/journey/user_journey/details', arguments: userJourney);
      },
      );
  }
}

