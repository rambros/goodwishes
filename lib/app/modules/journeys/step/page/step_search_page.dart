import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller/step_search_controller.dart';
import '/app/shared/utils/ui_utils.dart';

class StepSearchPage extends StatefulWidget {
  const StepSearchPage({Key? key}) : super(key: key);

  @override
  _StepSearchPageState createState() => _StepSearchPageState();
}

class _StepSearchPageState
    extends ModularState<StepSearchPage, StepSearchController> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Step'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                autovalidateMode: AutovalidateMode.always,
                initialValue: {
                  'text': '',
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    FormBuilderTextField(
                      name: 'text',
                      //autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Digite aqui o texto para pesquisa',
                      ),
                      validator: 
                        (val) {
                          var texto = val;
                          if ( (texto!.isEmpty || texto.length < 3)) {
                            return 'O texto precisa ter 3 ou mais caracteres.';
                              }
                        },
                      ),

                    verticalSpaceSmall,
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            child: Text(
                              'Pesquisar por título',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.save();
                              if (_fbKey.currentState!.validate()) {
                                print(_fbKey.currentState!.value);
                                var form = _fbKey.currentState!.value;
                                controller.searchSteps(
                                    text: form['text'],
                                );
                              } else {
                                print('validation failed');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            child: Text(
                              'Reset',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => _fbKey.currentState!.reset(),
                          ),
                        ),
                      ],
                    ),
                  ],
        ),
      ),
      ],
    ),
    )
    )
  );
  }
}
