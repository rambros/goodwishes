import 'step_model.dart';

class UserJourney {
  final String uid;
  final String userId;
  final String journeyId;
  final String? title;
  final String? description;
  final DateTime dateStarted;
  final DateTime dateCompleted;
  final int stepsTotal;
  int stepsCompleted;
  List<UserStep> userSteps;

  UserJourney(
    this.uid,
    this.userId, 
    this.journeyId, 
    this.title, 
    this.description, 
    this.dateStarted, 
    this.dateCompleted, 
    this.stepsCompleted, 
    this.stepsTotal, 
    this.userSteps, 
  );
}

class UserStep {
  final StepModel step;
  final String status;  //open, closed, completed
  final DateTime dateStarted;
  final DateTime dateCompleted;

  UserStep(
    this.step,
    this.status, 
    this.dateStarted, 
    this.dateCompleted, 
  ); 

}