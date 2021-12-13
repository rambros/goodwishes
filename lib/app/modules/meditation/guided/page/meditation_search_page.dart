import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/category/category_model.dart';
import '/app/modules/meditation/guided/controller/med_search_controller.dart';
import '/app/shared/utils/color.dart';
import '/app/shared/utils/ui_utils.dart';

class MeditationSearchPage extends StatefulWidget {
  const MeditationSearchPage({Key? key}) : super(key: key);

  @override
  _MeditationSearchPageState createState() => _MeditationSearchPageState();
}

class _MeditationSearchPageState
    extends ModularState<MeditationSearchPage, MeditationSearchController> {
  //use 'controller' variable to access controller

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Meditação'),
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
                  'category': [],
                  'authorid': ''
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
                          if ( (_fbKey.currentState!.fields['category']!.value.isEmpty)  
                                       &&
                             ( _fbKey.currentState!.fields['authorId']!.value == null )
                                      &&
                              (texto!.isEmpty || texto.length < 3)) {
                            return 'O texto precisa ter 3 ou mais caracteres.';
                              }
                        },
                      ),

                    verticalSpaceSmall,
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Pesquisar por título',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.save();
                              if (_fbKey.currentState!.validate()) {
                                print(_fbKey.currentState!.value);
                                var form = _fbKey.currentState!.value;
                                controller.searchMeditations(
                                    text: form['text'],
                                    authorId: '',
                                    categories: []);
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
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Limpar',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.reset();
                            },
                          ),
                        ),
                      ],
                    ),
                    //verticalSpaceMedium,

                    verticalSpaceSmall,
                    FormBuilderDropdown(
                      name: 'authorId',
                      //decoration: InputDecoration(labelText: 'Autor'),
                      hint: Text('Selecione o autor'),
                      //validators: [
                        // FormBuilderValidators.required(
                        //     errorText: 'Informação obrigatória'),
                      //],
                      items: controller.getListAuthors(),
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Pesquisar por Autor',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.save();
                              if (_fbKey.currentState!.validate()) {
                                print(_fbKey.currentState!.value);
                                var form = _fbKey.currentState!.value;
                                controller.searchMeditations(
                                    text: '',
                                    authorId: form['authorId'],
                                    categories: []);
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
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Limpar',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.reset();
                            },
                          ),
                        ),
                      ],
                    ),

                    verticalSpaceMedium,
                    Observer(
                      builder: (BuildContext context) {
                        return Center(
                          child: controller.hasCategories != null
                              ? FormBuilderFilterChip(
                                  name: 'category',
                                  backgroundColor: primaryColor,
                                  selectedColor: selectedColor,
                                  spacing: 4.0,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    //labelText:
                                    //    'Filtrar por uma ou mais categorias',
                                  ),
                                  options: controller
                                      .listaCategoriasField(kTipoMeditation),
                                  validator: 
                                      (val) {
                                        //String texto = val;
                                        if (_fbKey
                                                    .currentState!
                                                    .fields['text']!
                                                    .value
                                                    .isEmpty 
                                                    &&
                                            _fbKey
                                                    .currentState!
                                                    .fields['authorId']!
                                                    .value == null
                                                    &&
                                            val!.isEmpty) {
                                          return 'Selecione uma ou mais categorias';
                                            } 
                                      },
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
                    //verticalSpaceMedium,
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Filtrar por categoria',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState!.save();
                        if (_fbKey.currentState!.validate()) {
                          print(_fbKey.currentState!.value);
                          var form = _fbKey.currentState!.value;
                          controller.searchMeditations(
                              text: '',
                              authorId: '',
                              categories: form['category'].cast<String>());
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
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Limpar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState!.reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
