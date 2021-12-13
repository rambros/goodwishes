// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryListController on _CategoryListControllerBase, Store {
  Computed<ObservableList<Category>>? _$categoriesTipoPostComputed;

  @override
  ObservableList<Category> get categoriesTipoPost =>
      (_$categoriesTipoPostComputed ??= Computed<ObservableList<Category>>(
              () => super.categoriesTipoPost,
              name: '_CategoryListControllerBase.categoriesTipoPost'))
          .value;
  Computed<ObservableList<Category>>? _$categoriesTipoMeditationComputed;

  @override
  ObservableList<Category> get categoriesTipoMeditation =>
      (_$categoriesTipoMeditationComputed ??=
              Computed<ObservableList<Category>>(
                  () => super.categoriesTipoMeditation,
                  name: '_CategoryListControllerBase.categoriesTipoMeditation'))
          .value;
  Computed<ObservableList<Category>>? _$visibleCategoriesComputed;

  @override
  ObservableList<Category> get visibleCategories =>
      (_$visibleCategoriesComputed ??= Computed<ObservableList<Category>>(
              () => super.visibleCategories,
              name: '_CategoryListControllerBase.visibleCategories'))
          .value;

  final _$_categoriesAtom =
      Atom(name: '_CategoryListControllerBase._categories');

  @override
  ObservableList<Category> get _categories {
    _$_categoriesAtom.reportRead();
    return super._categories;
  }

  @override
  set _categories(ObservableList<Category> value) {
    _$_categoriesAtom.reportWrite(value, super._categories, () {
      super._categories = value;
    });
  }

  final _$_busyAtom = Atom(name: '_CategoryListControllerBase._busy');

  @override
  bool get _busy {
    _$_busyAtom.reportRead();
    return super._busy;
  }

  @override
  set _busy(bool value) {
    _$_busyAtom.reportWrite(value, super._busy, () {
      super._busy = value;
    });
  }

  final _$filterAtom = Atom(name: '_CategoryListControllerBase.filter');

  @override
  VisibilityFilter? get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(VisibilityFilter? value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$_CategoryListControllerBaseActionController =
      ActionController(name: '_CategoryListControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_CategoryListControllerBaseActionController
        .startAction(name: '_CategoryListControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_CategoryListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFilter(VisibilityFilter filter) {
    final _$actionInfo = _$_CategoryListControllerBaseActionController
        .startAction(name: '_CategoryListControllerBase.changeFilter');
    try {
      return super.changeFilter(filter);
    } finally {
      _$_CategoryListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
categoriesTipoPost: ${categoriesTipoPost},
categoriesTipoMeditation: ${categoriesTipoMeditation},
visibleCategories: ${visibleCategories}
    ''';
  }
}
