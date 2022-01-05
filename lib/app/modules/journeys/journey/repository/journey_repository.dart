import './../../model/models.dart';

abstract class JourneyRepository {
  Stream listenToJourneys();
  Future addJourney(Journey journey);
  Future deleteJourney(String? journeyId);
  Future updateJourney(Journey? journey, Map<String, dynamic> updateMap); 

  Future updateSteps(Journey? journey, List<StepModel>? steps);
  Future updateStep({required String journeyId, required StepModel step});
  Future deleteStep({required String journeyId, required StepModel step}); 
  Future addStep({required String journeyId, required StepModel step}); 
}