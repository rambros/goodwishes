import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '/app/shared/author/controller/author_edit_controller.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/ui_utils.dart';

class AuthorEditPage extends StatefulWidget {
  final UserApp? author;
  const AuthorEditPage({Key? key, this.author}) : super(key: key);

  @override
  _AuthorEditPageState createState() => _AuthorEditPageState();
}

class _AuthorEditPageState
    extends ModularState<AuthorEditPage, AuthorEditController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.setEdittingAuthor(widget.author);

    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blueAccent,
          title: Text('Editar Autor'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'curriculum': widget.author?.curriculum ?? '',
                    'contact': widget.author!.contact ?? '',
                    //'site': widget.author.site ?? '',
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
                      // FormBuilderTextField(
                      //   attribute: 'site',
                      //   maxLines: 1,
                      //   decoration: InputDecoration(
                      //     labelText: 'Endereço do Site ou Rede Social',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //   ),
                      //   validators: [
                      //     FormBuilderValidators.max(80),
                      //     FormBuilderValidators.required(
                      //         errorText: 'Informação obrigatória'),
                      //   ],
                      // ),
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
                            controller.editAuthor(
                              curriculum: form['curriculum'],
                              contact: form['contact'],
                              //site: form['site'],
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
