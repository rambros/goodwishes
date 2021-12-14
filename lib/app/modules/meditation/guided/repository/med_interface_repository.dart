import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/comment/comment.dart';

abstract class IMeditationRepository {

  
  Future getMeditationsOnceOff();
  Stream listenToMeditationsRealTime();

  //Future addMeditation(Meditation meditation);
  Future searchMeditations(String text); 
  //Future deleteMeditation(String documentId);
  Future changeToDraftStep(String? documentId);
  Future updateMeditation(Meditation? meditation, Map<String, dynamic> updateMap); 

  Future updateMeditationComments(Meditation? meditation, List<Comment>? listComments);
  Future deleteMeditationComments(Meditation? meditation, Comment comment); 
  Future deleteCategory(String? categoryValue);
  Future updateNumLikedMeditation(Meditation? meditation);
  Future updateNumPlayedMeditation(Meditation? meditation);
}