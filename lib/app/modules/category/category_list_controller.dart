// ignore_for_file: prefer_final_fields

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/modules/meditation/guided/repository/med_interface_repository.dart';
import '/app/shared/services/dialog_service.dart';
import 'category_model.dart';
import 'category_repository.dart';

part 'category_list_controller.g.dart';

enum VisibilityFilter { todos, reflection, meditation, post }

class CategoryListController = _CategoryListControllerBase
    with _$CategoryListController;

abstract class _CategoryListControllerBase with Store {
  final _categoryRepository = Modular.get<CategoryRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _medRepository = Modular.get<IMeditationRepository>();

  bool isListeningCategories = false;

  @observable
  var _categories = ObservableList<Category>();

  void init() async {
    var tempList = await _categoryRepository.getCategoryOnceOff();
    //tempList.forEach((value) => print(value.valor));
    tempList
        .sort((a, b) => a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));
    tempList.forEach((category) => _categories.add(category));
  }
  //to get the order other way just switch `adate & bdate`

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  String getTipoCategoria(tipo) {
    switch (tipo) {
      case (kTipoPost):
        return 'Sugestão';
      case (kTipoMeditation):
        return 'Meditação';
      default:
        return 'Meditação';
    }
  }

  @computed
  ObservableList<Category> get categoriesTipoPost => ObservableList.of(
      _categories.where((category) => category.tipo == kTipoPost));

  @computed
  ObservableList<Category> get categoriesTipoMeditation => ObservableList.of(
      _categories.where((category) => category.tipo == kTipoMeditation));

  //List<Category> get categories => _listCategories;
  ObservableList<Category> get categories => _categories;

  @observable
  VisibilityFilter? filter = VisibilityFilter.todos;

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

  Future deleteCategory(Category category) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer deletar esta categoria?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );

    if (dialogResponse.confirmed!) {
      //remove categoria da collection category
      setBusy(true);
      await _categoryRepository.deleteCategory(category.documentId);
      setBusy(false);

      //remove categoria de cada doc (post,reflection,meditation)
      switch (category.tipo) {
        case kTipoPost:
          //await _postRepository.deleteCategory(category.valor);
          break;
        case kTipoMeditation:
          await _medRepository.deleteCategory(category.valor);
          break;
      }

      // remove categoria da lista observable
      _categories.remove(category);
    }
  }

  void addCategory() {
    Modular.to.pushReplacementNamed('/category/add');
  }

  void editCategory(int index) {
    //Modular.to.pushNamed('/category/edit', arguments: _categories[index]);
  }

  // void showCategoryDetails(int index) {
  //   Modular.to.pushNamed('/category/details', arguments: _categories[index]);
  // }

}
