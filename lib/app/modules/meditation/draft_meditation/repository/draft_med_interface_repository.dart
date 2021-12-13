import '/app/modules/meditation/guided/model/meditation.dart';

abstract class IDraftMeditationRepository {
  
  Future getDraftMeditationsOnceOff();
  Stream listenToDraftMeditationsRealTime();

  Future addDraftMeditation(Meditation meditation);
  Future publishMeditation(String? documentId);
  Future searchDraftMeditations(String text); 
  Future deleteDraftMeditation(String? documentId);
  Future updateDraftMeditation(Meditation? meditation, Map<String, dynamic> updateMap); 

}