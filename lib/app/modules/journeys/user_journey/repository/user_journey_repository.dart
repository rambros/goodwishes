import 'package:dartz/dartz.dart';

import './../../../journeys/error/failures.dart';
import './../../model/models.dart';

abstract class UserJourneyRepository {
  Stream listenToUserJourneys();
  //Future<UserJourney> addUserJourney(UserJourney journey);
  Future<Either<Failure, UserJourney>> addUserJourney(UserJourney journey);

  // Future updateJourney(Journey? journey, Map<String, dynamic> updateMap); 
  // Future updateSteps(Journey? journey, List<StepModel>? steps);
  // Future updateStep({required String journeyId, required StepModel step});
}