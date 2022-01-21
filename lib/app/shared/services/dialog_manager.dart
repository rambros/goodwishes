import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/services/dialog_models.dart';

import 'dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;
  DialogManager({Key? key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = Modular.get<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(DialogRequest request) {
    //var isConfirmationDialog = request.cancelTitle != null;

    showDialog(
        context: context,
        builder: (context) => AlertDialogDispatcher(request)
        // ? _passwordDialog(request)
        // : _alertDialog(request, isConfirmationDialog));
    );
  }

  AlertDialog AlertDialogDispatcher( DialogRequest request ) {
    switch (request.type) {
      case 'dialog':
          return _alertDialog(request); 
      case 'input_password': 
        return _passwordDialog(request);
      case 'confirmation_dialog':
          return _confirmationDialog(request); 
      case 'timer_duration':
          return _inputDuration(request); 
      default:
         return _alertDialog(request);
    }
  }

  AlertDialog _alertDialog(DialogRequest request ) {
    return AlertDialog(
            title: Text(request.title!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            content: Text(request.description!),
            actions: <Widget>[
              TextButton(
                child: Text(request.buttonTitle),
                onPressed: () {
                  _dialogService
                      .dialogComplete(DialogResponse(confirmed: true));
                },
              ),
            ],
          );
  }

  AlertDialog _confirmationDialog(DialogRequest request) {
    return AlertDialog(
            title: Text(request.title!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            content: Text(request.description!),
            actions: <Widget>[
                TextButton(
                  child: Text(request.cancelTitle!),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: false));
                  },
                ),
              TextButton(
                child: Text(request.buttonTitle),
                onPressed: () {
                  _dialogService
                      .dialogComplete(DialogResponse(confirmed: true));
                },
              ),
            ],
          );
  }

    AlertDialog _passwordDialog(DialogRequest request) {
      var _password = TextEditingController();
    return AlertDialog(
            title: Text(request.title!),
            content: Container(
              height: 180,
              child: Column(
                children: <Widget>[
                  Text( request.description!),
                  SizedBox(height:30),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Senha',
                    ),
                  ),
                ]
              )
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(request.cancelTitle!),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: false));
                  },
                ),
              TextButton(
                child: Text(request.buttonTitle),
                onPressed: () {
                  _dialogService
                      .dialogComplete(DialogResponse(confirmed: true, fieldOne: _password.text));
                },
              ),
            ],
          );
  }

  
    AlertDialog _inputDuration(DialogRequest request) {
      var _password = TextEditingController();
    return AlertDialog(
            title: Text(request.title!),
            content: Container(
              height: 180,
              child: Column(
                children: <Widget>[
                  Text( request.description!),
                  SizedBox(height:30),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Senha',
                    ),
                  ),
                ]
              )
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(request.cancelTitle!),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: false));
                  },
                ),
              TextButton(
                child: Text(request.buttonTitle),
                onPressed: () {
                  _dialogService
                      .dialogComplete(DialogResponse(confirmed: true, fieldOne: _password.text));
                },
              ),
            ],
          );
  }



}
