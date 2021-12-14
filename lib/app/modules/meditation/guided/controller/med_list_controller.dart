import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/services/user_service.dart';
import '../../../../shared/services/dialog_service.dart';
import '../../../category/category_controller.dart';
import '../../guided/model/meditation.dart';
import '../../guided/repository/med_firebase_controller.dart';
import '../../guided/repository/med_interface_repository.dart';

part 'med_list_controller.g.dart';

class MeditationListController = _MeditationListControllerBase with _$MeditationListController;

abstract class _MeditationListControllerBase with Store {
  final _meditationRepository = Modular.get<IMeditationRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _categoryController = Modular.get<CategoryController>();
  final _medFirebaseController = Modular.get<MeditationFirebaseController>();

  // String get getUserRole => _authenticationService.status == AuthenticationStatus.loggedIn
  //                            ?  _authenticationService.currentUser
  //                            : "not logged";

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  bool? get hasCategories => _categoryController.categories == null ? null : true;

  @observable
  List<Meditation> _meditations = <Meditation>[];
  List<Meditation> _meditationsFeatured = <Meditation>[];
  @observable
  List<Meditation> _meditationsFiltered = <Meditation>[];

  List<Meditation> get meditations => _meditations;
  List<Meditation> get meditationsFiltered => _meditationsFiltered;

  bool isListeningMeditations = false;
  void init() {
    //mudança para diminuir leituras 
    //if (!isListeningMeditations) listenToMeditations();
    _meditations = _medFirebaseController.meditations;
    _meditationsFiltered = List<Meditation>.from(_meditations);
  }

  @action
   void filterByCategory (String? category) {
    if (_meditations == null) return null;
    _meditationsFiltered = List<Meditation>.from(_meditations);
    if (category != null) {
        _meditationsFiltered = _meditationsFiltered.where((med) => med.category!.contains(category)).toList();
    }
  } 

  List<Meditation>? get listFeatured {
    if (_meditations == null) return null;
    _meditationsFeatured = _meditations.where((ref) => ref.featured == true).toList();
    if (_meditationsFeatured == null) {
      return null;
    } else {
      return _meditationsFeatured;
    }
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  // void listenToMeditations() {
  //   setBusy(true);
  //   isListeningMeditations = true;
  //   _meditationRepository.listenToMeditationsRealTime().listen((meditationsData) {
  //     List<Meditation> updatedMeditations = meditationsData;
  //     if (updatedMeditations != null && updatedMeditations.isNotEmpty) {
  //       _meditations = updatedMeditations;
  //       _meditations.sort((a, b) => b.date.compareTo(a.date));
  //       _meditationsFiltered = List<Meditation>.from(_meditations);
  //     }

  //     setBusy(false);
  //   });
  //   setBusy(false);
  // }

  Future changeStatusToDraft(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer alterar o status desta meditação para draft?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );
    if (dialogResponse.confirmed!) {
      setBusy(true);
        var result = await _meditationRepository.changeToDraftStep(_meditationsFiltered[index].documentId);
        if (result is String) {
          await _dialogService.showDialog(
            title: 'Não foi possivel mudar o status da meditação',
            description: result,
          );
        } else {
          await _dialogService.showDialog(
            title: 'Meditação alterada com sucesso',
            description: 'Meditação alterada para draft',
          );
        }
    }
    setBusy(false);
  }

 
  void addMeditation() {
    Modular.to.pushNamed('/meditation/add');
  }

  void editMeditation(int index) {
    Modular.to.pushNamed('/meditation/edit', arguments: _meditationsFiltered[index]);
  }

  void searchMeditation() {
    Modular.to.pushNamed('/meditation/search');
  }

  void showMeditationDetails(int index) {
    Modular.to.pushNamed('/meditation/details', arguments: _meditationsFiltered[index]);
  }

  void showMeditationDetailsFeatured(int index) {
    Modular.to
        .pushNamed('/meditation/details', arguments: _meditationsFeatured[index]);
  }
  // monta um list de chips de categorias para usuario selecionar
  List<FormBuilderFieldOption> listaCategoriasField(String type) {
    var textFields = <FormBuilderFieldOption>[];
    var _listaCategorias = _categoryController.categories!;
    _listaCategorias.forEach((categoria) {
      if (categoria.tipo == type) {
        textFields.add( FormBuilderFieldOption(
            value: categoria.valor,
            child: Text(categoria.nome!), 
        ));
      }
    });
    return textFields;
  }

}
