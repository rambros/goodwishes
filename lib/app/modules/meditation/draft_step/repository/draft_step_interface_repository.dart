import 'package:goodwishes/app/modules/meditation/guided/model/step_model.dart';

abstract class IDraftStepRepository {
  
  Future getDraftStepsOnceOff();
  Stream listenToDraftStepsRealTime();

  Future addDraftStep(StepModel stepModel);
  Future publishStep(String? documentId);
  Future searchDraftSteps(String text); 
  Future deleteDraftStep(String? documentId);
  Future updateDraftStep(StepModel? stepModel, Map<String, dynamic> updateMap); 

}