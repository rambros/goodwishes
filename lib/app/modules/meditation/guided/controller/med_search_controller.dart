import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import './../../guided/model/meditation.dart';
import './../../../../modules/category/category_controller.dart';
import './../../../../shared/author/controller/author_controller.dart';

part 'med_search_controller.g.dart';

class MeditationSearchController = _MeditationSearchControllerBase
    with _$MeditationSearchController;

abstract class _MeditationSearchControllerBase with Store {
  final CollectionReference _meditationsCollectionReference =
      FirebaseFirestore.instance.collection('meditations');
  final _categoryController = Modular.get<CategoryController>();
  final _authorController = Modular.get<AuthorController>();
    
  String? text;
  List<String>? categories;

  bool? get hasCategories =>
      _categoryController.categories == null ? null : true;

  
  void searchMeditations({
    String? text, 
    String? authorId,
    List<String>? categories}
    ) async {
    //print(categories);
    //print(text);

    // monta query para repositorio
    late var meditationDocumentSnapshot;
    //se tem texto
    if (text != null && text.isNotEmpty) {
            meditationDocumentSnapshot = await _meditationsCollectionReference
              .where('titleIndex', arrayContains: text)
              .get();
    } else {
      if ( categories!.isNotEmpty) {
            meditationDocumentSnapshot = await _meditationsCollectionReference
              .where('category', arrayContainsAny: categories)
              .get();
      } else 
        if ( authorId!.isNotEmpty) {
            meditationDocumentSnapshot = await _meditationsCollectionReference
              .where('authorId', isEqualTo: authorId)
              .get();
    }
    }

    List<Meditation>? listaMeditations = <Meditation>[];
    if (meditationDocumentSnapshot.docs.isNotEmpty) {
      listaMeditations = meditationDocumentSnapshot.docs
          //return meditationDocumentSnapshot.documents
          .map((snapshot) => Meditation.fromMap(snapshot.data(), snapshot.id))
          .where((mappedItem) => mappedItem.title != null)
          .toList()
          .cast<Meditation>();
    }

    // envia para pagina de resultados
    await Modular.to.pushReplacementNamed('/meditation/results', arguments: listaMeditations );
  }

  // monta um list de chips de categorias para usuario selecionar
  List<FormBuilderFieldOption> listaCategoriasField(String type) {
    var textFields = <FormBuilderFieldOption>[];
    var _listaCategorias = _categoryController.categories!;
    _listaCategorias.forEach((categoria) {
      if (categoria.tipo == type) {
        textFields.add(FormBuilderFieldOption(
            value: categoria.valor,
            child: Text(categoria.nome!),
          )
        );
      }
    });
    return textFields;
  }

   List<DropdownMenuItem<dynamic>> getListAuthors() {
    var listAuthors = _authorController.authors!;
    return listAuthors
        .map(
          (user) => DropdownMenuItem(
            value: user.uid,
            child: Text('${user.fullName}'),
          ),
        )
        .toList();
  }
}
