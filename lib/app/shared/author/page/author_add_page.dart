import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '/app/shared/author/controller/author_add_controller.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/ui_utils.dart';

class AuthorAddPage extends StatefulWidget {
  final UserApp? author;
  const AuthorAddPage({Key? key, this.author}) : super(key: key);

  @override
  _AuthorAddPageState createState() => _AuthorAddPageState();
}

class _AuthorAddPageState
    extends ModularState<AuthorAddPage, AuthorAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Autor'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                verticalSpace(24.0),
                Text('selecione Autor'),
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'curriculum': '',
                    'contact': '',
                    'site': '',
                  },
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      verticalSpace(16.0),
                      FormBuilderTextField(
                        name: 'curriculum',
                        maxLines: 20,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          labelText: 'Curriculum do Autor',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'Informação obrigatória'),
                        ]),
                      ),
                      verticalSpaceSmall,
                      FormBuilderTextField(
                        name: 'contact',
                        decoration: InputDecoration(
                          labelText: 'Meio principal de contato com o autor',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      FormBuilderTextField(
                        name: 'site',
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Endereço do Site ou Rede Social',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.max(context,80),
                          FormBuilderValidators.required(context,
                              errorText: 'Informação obrigatória'),
                        ]),
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Atualizar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _fbKey.currentState!.save();
                          if (_fbKey.currentState!.validate()) {
                            print(_fbKey.currentState!.value);
                            var form = _fbKey.currentState!.value;
                            controller.addAuthor(
                              curriculum: form['curriculum'],
                              contact: form['contact'],
                              site: form['site'],
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
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _fbKey.currentState!.reset();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
