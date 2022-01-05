import '/app/modules/journeys/model/models.dart';

class JourneyStepArgs {
  final String journeyId;
  final StepModel? step;

  JourneyStepArgs({ required this.journeyId, this.step});
}
