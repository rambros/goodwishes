import 'dart:async';

import 'package:flutter/cupertino.dart';
import '/app/shared/services/dialog_models.dart';

class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  late Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse>? _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String? title,
    String? description,
    String buttonTitle = 'Ok',
    String type = 'dialog',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
      type: type,
    ));
    return _dialogCompleter!.future;
  }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog(
      {String? title,
      String? description,
      String confirmationTitle = 'Ok',
      String cancelTitle = 'Cancel',
      String type = 'confirmation_dialog'}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle,
        type: type,));
    return _dialogCompleter!.future;
  }

   Future<DialogResponse> showInputPassword({
    String? title,
    String? description,
    String buttonTitle = 'Ok',
    String cancelTitle = 'Cancelar',
    String type = 'input_password',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
      cancelTitle: cancelTitle,
      type: type,
    ));
    return _dialogCompleter!.future;
  }

  
   Future<DialogResponse> showInputDuration({
    String? title,
    String? description,
    String buttonTitle = 'Ok',
    String cancelTitle = 'Cancelar',
    String type = 'timer_duration',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
      cancelTitle: cancelTitle,
      type: type,
    ));
    return _dialogCompleter!.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState!.pop(response.fieldOne);
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
}
