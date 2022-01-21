import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:goodwishes/app/modules/journeys/model/models.dart';

import '../user_journey.dart';
import '/app/shared/services/services.dart';

part 'user_journey_list_state.dart';
part 'user_journey_list_cubit.freezed.dart';

class UserJourneyListCubit extends Cubit<UserJourneyListState> {

  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _journeyUserRepository = Modular.get<UserJourneyRepository>();
  
  UserJourneyListCubit() : super(UserJourneyListState.initial());

  List<UserJourney>? _userJourneys;
  List<UserJourney>? get userJourneys => _userJourneys;

  bool isListeningUserJourneys = false;
  void init() {
    if (!isListeningUserJourneys) listenToUserJourneys();
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  void listenToUserJourneys() {
    emit(UserJourneyListState.loading());
    isListeningUserJourneys = true;
    _journeyUserRepository.listenToUserJourneys().listen((journeyData) {
      List<UserJourney> updatedUserJourneys = journeyData;
      if (updatedUserJourneys.isNotEmpty) {
        _userJourneys = updatedUserJourneys;
        _userJourneys!.sort((a, b) => b.title!.compareTo(a.title!));
      }
      emit(UserJourneyListState.success(_userJourneys));
    });
    //setBusy(false);
  }

  Future cancelUserJourney(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you shure?',
      description: 'You want to cancel your journey?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed!) {
      var journeyToDelete = _userJourneys![index];
      emit(UserJourneyListState.loading());
      //await _userJourneyRepository.deleteJourney(_userJourneys![index].journeyId);
      emit(UserJourneyListState.success(_userJourneys));
    }
  }



  void showUserJourneyDetails(int index) {
    Modular.to.pushNamed('journeys/user_journey/details', arguments: _userJourneys![index]);
  }


}
