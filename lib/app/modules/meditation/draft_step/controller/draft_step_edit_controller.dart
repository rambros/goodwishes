import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repository/draft_step_interface_repository.dart';
import '/app/modules/meditation/guided/model/step_model.dart';

import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/explode_title.dart';

part 'draft_step_edit_controller.g.dart';

class DraftStepEditController = _DraftStepEditControllerBase with _$DraftStepEditController;

abstract class _DraftStepEditControllerBase with Store {
  final _DraftStepRepository = Modular.get<IDraftStepRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  void init() {
  }

   StepModel? _edittingStep;

  String? imageUrl;
  String? get getImageUrl => imageUrl;
  String? imageFileName;

  @action
  Future editDraftStep(
      {required String title,
      //String date,
      String? callText,
      String? detailsText,
      }) async {
    setBusy(true);

    var result;

    var titleIndex = explodeTitle(title);

    // está editando Meditationlexão
    var updateMap = {
      'title': title,
      'callText': callText,
      'detailsText': detailsText,
      'titleIndex': titleIndex = List<String>.from(titleIndex.map((x) => x)),
    };

    result = await _DraftStepRepository.updateDraftStep(_edittingStep, updateMap);

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel atualizar a Meditação',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Meditação atualizada com sucesso',
        description: 'Sua Meditação foi atualizada',
      );
    }

    Modular.to.pop();
  }

  void setEdittingStep(StepModel? edittingStep) {
    _edittingStep = edittingStep;
  }

}
