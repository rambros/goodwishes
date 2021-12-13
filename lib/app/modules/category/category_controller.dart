import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'category_model.dart';
import 'category_repository.dart';

part 'category_controller.g.dart';

enum VisibilityFilter { todos, reflection, meditation, post }

class CategoryController = _CategoryControllerBase with _$CategoryController;

abstract class _CategoryControllerBase with Store {
  final _categoryRepository = Modular.get<CategoryRepository>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<Category>? _listCategories;

  List<Category>? get categories => _listCategories;

  void listenToCategories() {
    setBusy(true);
    //isListeningCategories = true;
    _categoryRepository.listenToCategoryRealTime().listen((categoriesData) {
      List<Category> updatedCategories = categoriesData;
      if (updatedCategories != null && updatedCategories.isNotEmpty) {
        _listCategories = updatedCategories;
      }
      //print(_listCategories);
      setBusy(false);
    });
  }

  // monta um list de chips de categorias para usuario selecionar
  List<FormBuilderFieldOption> listaCategoriasField(String? tipo) {
    List<FormBuilderFieldOption<String?>> textFields = <FormBuilderFieldOption<String>>[];
    var _listaCategorias = _listCategories!;
    _listaCategorias.sort((a, b) => a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));
    _listaCategorias.forEach((categoria) {
      if (tipo == 'todas') {
        textFields.add( FormBuilderFieldOption(
            child: Text(categoria.nome!), value: categoria.valor));
      } else {
        if (categoria.tipo == tipo) {
          textFields.add( FormBuilderFieldOption(
              child: Text(categoria.nome!), value: categoria.valor));
        }
      }
    });
    return textFields;
  }
}
