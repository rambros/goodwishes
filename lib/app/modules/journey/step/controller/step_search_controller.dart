import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/app/modules/journey/model/step_model.dart';

part 'step_search_controller.g.dart';

class StepSearchController = _StepSearchControllerBase
    with _$StepSearchController;

abstract class _StepSearchControllerBase with Store {
  final CollectionReference _stepsCollectionReference =
      FirebaseFirestore.instance.collection('steps');
    
  String? text;
  
  void searchSteps({String? text}) async {
    late var stepDocumentSnapshot;
    if (text != null && text.isNotEmpty) {
            stepDocumentSnapshot = await _stepsCollectionReference
              .where('titleIndex', arrayContains: text)
              .get();
    } 
    List<StepModel>? listaSteps = <StepModel>[];
    if (stepDocumentSnapshot.docs.isNotEmpty) {
      listaSteps = stepDocumentSnapshot.docs
          .map((snapshot) => StepModel.fromMap(snapshot.data(), snapshot.id))
          .where((mappedItem) => mappedItem.title != null)
          .toList()
          .cast<StepModel>();
    }

    // envia para pagina de resultados
    await Modular.to.pushReplacementNamed('/journey/results', arguments: listaSteps );
  }
}
