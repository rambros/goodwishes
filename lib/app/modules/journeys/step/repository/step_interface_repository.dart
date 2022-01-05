import '/app/modules/journeys/model/step_model.dart';
import '/app/shared/comment/comment.dart';

abstract class IStepRepository {
  Future getStepsOnceOff();
  Stream listenToStepsRealTime();

  Future searchSteps(String text); 
  Future changeToDraftStep(String? documentId);
  Future updateStep(StepModel? step, Map<String, dynamic> updateMap); 

  Future updateStepComments(StepModel? step, List<Comment>? listComments);
  Future deleteStepComments(StepModel? step, Comment comment); 
  Future updateNumLikedStep(StepModel? step);
  Future updateNumPlayedStep(StepModel? step);
}