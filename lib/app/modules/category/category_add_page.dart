import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'category_add_controller.dart';
import 'category_model.dart';
import '/app/shared/utils/ui_utils.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryAddPageState createState() => _CategoryAddPageState();
}

class _CategoryAddPageState
    extends ModularState<CategoryAddPage, CategoryAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova categoria'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'tipo': '',
                  'nome': '',
                  'valor': '',
                },
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(16),
                    FormBuilderTextField(
                      name: 'nome',
                      decoration: InputDecoration(
                          labelText: 'Nome da Categoria',
                          labelStyle: TextStyle(
                            //color: Colors.black,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      validator: FormBuilderValidators.compose([
                                FormBuilderValidators.max(context, 30),
                              ]),
                    ),
                    verticalSpaceSmall,
                    FormBuilderRadioGroup(
                      name: 'tipo',
                      decoration: InputDecoration(
                        labelText: 'Tipo da categoria',
                        labelStyle: TextStyle(
                          //color: Colors.black,
                          fontSize: 20,
                        ),
                        //border: InputBorder.none,
                      ),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      //leadingInput: true,
                      options: [
                        FormBuilderFieldOption(
                          value: kTipoPost, // VisibilityFilter.post,
                          child: Text('Publicação'),
                        ),
                        FormBuilderFieldOption(
                          value: kTipoMeditation, //VisibilityFilter.meditation,
                          child: Text('Meditação'),
                        ),
                      ],
                      onChanged: (dynamic filter) => controller.changeTipo(filter),
                    ),
                    verticalSpaceSmall,
                    Observer(
                      builder: (BuildContext context) {
                        return Center(
                          child: controller.categories != null
                              ? FormBuilderFilterChip(
                                  enabled: true,
                                  name: 'category',
                                  spacing: 4.0,
                                  decoration: InputDecoration(
                                    labelText: 'Categorias já existentes',
                                    labelStyle: TextStyle(
                                      //color: Colors.black,
                                      fontSize: 22,
                                    ),
                                    fillColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                  options: controller.listaCategoriasField(
                                      controller.tipoFilter),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium,
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState!.save();
                        if (_fbKey.currentState!.validate()) {
                          print(_fbKey.currentState!.value);
                          var form = _fbKey.currentState!.value;
                          controller.addCategory(
                            nome: form['nome'],
                            valor: form['nome'],
                            tipo: form['tipo'],
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
                        'Cancelar',
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
      ),
    );
  }
}
