import '/app/modules/journeys/model/models.dart';

class UserJourneyStepArgs {
  final String userJourneyId;
  final UserStep? userStep;

  const UserJourneyStepArgs({ required this.userJourneyId, this.userStep});
}
