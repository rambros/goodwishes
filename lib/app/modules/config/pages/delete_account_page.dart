import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/config/controller/delete_account_controller.dart';
import '/app/shared/utils/ui_utils.dart';

class DeleteAccountPage extends StatefulWidget {
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState
    extends ModularState<DeleteAccountPage, DeleteAccountController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueAccent,
        title: Text('Apagar Conta e Dados'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 126,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                      'Você realmente quer deletar todos os dados e apagar sua conta?'),
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                           //color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    //Modular.to.pushNamed('/config');
                    Modular.to.pop();
                  },
                ),
                verticalSpace(48),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Apagar todos os dados e deletar conta',
                    style: TextStyle(
                        //color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    controller.deleteAccount();
                  },
                ),
              ],
            )),
      ),
    );
  }
}
