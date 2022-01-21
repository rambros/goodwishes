part of 'user_journey_list_cubit.dart';

@freezed
class UserJourneyListState with _$UserJourneyListState {
  const factory UserJourneyListState.initial() = _Initial;
  const factory UserJourneyListState.loading() = _Loading;
  const factory UserJourneyListState.error(String message, int lastNumberBeforeError) = _Error;
  const factory UserJourneyListState.success(List<UserJourney>? userJourneys) = _Success;


  
}
