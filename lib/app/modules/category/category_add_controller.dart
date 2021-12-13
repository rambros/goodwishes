
// ignore_for_file: prefer_final_fields

import 'package:mobx/mobx.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/dialog_service.dart';
import 'category_repository.dart';
import 'category_model.dart';
import 'category_controller.dart';

part 'category_add_controller.g.dart';

enum VisibilityFilter { todas, reflection, meditation, post }

class CategoryAddController = _CategoryAddControllerBase
    with _$CategoryAddController;

abstract class _CategoryAddControllerBase with Store {
  final _categoryRepository = Modular.get<CategoryRepository>();
  final _categoryController = Modular.get<CategoryController>();
  final _dialogService = Modular.get<DialogService>();

  bool isListeningCategories = false;

  @observable
  var _categories = ObservableList<Category>();

  void init() async {
    var tempList = await _categoryRepository.getCategoryOnceOff();
    tempList.sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    tempList.forEach((category) => _categories.add(category));
  }

  ObservableList<Category> get categories => _categories;

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  Future addCategory(
    {required String? nome,
    required String? valor,
    required String? tipo,}
  ) async {

    String? result = await _categoryRepository.addCategory(
      Category(
        tipo: tipo,
        nome: nome,
        valor: valor)
    );

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar a Categoria',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Categoria adicionada com sucesso',
        description: 'Sua Categoria foi adicionada',
      );
    }
    await Modular.to.pushReplacementNamed('/category/add');
  }

    List<FormBuilderFieldOption> listaCategoriasField(String? tipo) {
      return _categoryController.listaCategoriasField(tipo);
  }

  @computed
  ObservableList<Category> get categoriesTipoPost => ObservableList.of(
      _categories.where((category) => category.tipo == kTipoPost));

  @computed
  ObservableList<Category> get categoriesTipoMeditation => ObservableList.of(
      _categories.where((category) => category.tipo == kTipoMeditation));

  @observable
  VisibilityFilter filter = VisibilityFilter.todas;

  @computed
  ObservableList<Category> get visibleCategories {
    switch (filter) {
      case VisibilityFilter.post:
        return categoriesTipoPost;
      case VisibilityFilter.meditation:
        return categoriesTipoMeditation;
      default:
        return categories;
    }
  }

  @action
  void changeFilter(VisibilityFilter filter) => this.filter = filter;

  @observable
  String? tipoFilter = 'todas';

  @action
  void changeTipo (String? tipo) => tipoFilter = tipo;

}
