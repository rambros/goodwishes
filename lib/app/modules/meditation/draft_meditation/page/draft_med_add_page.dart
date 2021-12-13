import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '/app/modules/category/category_model.dart';
import '/app/modules/meditation/draft_meditation/controller/draft_med_add_controller.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/color.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

class DraftMeditationAddPage extends StatefulWidget {
  const DraftMeditationAddPage({
    Key? key,
  }) : super(key: key);

  @override
  _DraftMeditationAddPageState createState() => _DraftMeditationAddPageState();
}

class _DraftMeditationAddPageState
    extends ModularState<DraftMeditationAddPage, DraftMeditationAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();
  bool _novaImagem = false;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nova Meditação'),
        ),
        body: controller.busy
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Aguarde enquanto os arquivos são salvos'),
                      verticalSpace(30),
                      CircularProgressIndicator(),
                    ],
                  ),
                ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      FormBuilder(
                        key: _fbKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpace(16),
                            FormBuilderTextField(
                              name: 'title',
                              initialValue: '',
                              decoration: InputDecoration(
                                labelText: 'Título',
                                labelStyle: inputFieldTextStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.max(context,50),
                                  FormBuilderValidators.required(context,
                                      errorText: 'Informação obrigatória'),
                              ]),
                            ),
                            verticalSpaceSmall,
                            FormBuilderDropdown(
                              name: 'authorId',
                              decoration: InputDecoration(
                                labelText: 'Autor',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              hint: Text('Selecione o autor do aúdio'),
                              validator: FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              items: controller.getListAuthors(),
                            ),
                            verticalSpaceSmall,
                            FormBuilderTextField(
                              name: 'authorText',
                              initialValue: '',
                              decoration: InputDecoration(
                                labelText: 'Autor do texto',
                                labelStyle: inputFieldTextStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.max(context,50),
                                FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              ]),
                            ),
                            verticalSpaceSmall,
                            FormBuilderTextField(
                              name: 'authorMusic',
                              initialValue: '',
                              decoration: InputDecoration(
                                labelText: 'Autor da música',
                                labelStyle: inputFieldTextStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.max(context,50),
                                FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              ]),
                            ),
                            verticalSpaceSmall,
                            Observer(
                              builder: (BuildContext context) {
                                return Center(
                                  child: controller.hasCategories != null
                                      ? FormBuilderFilterChip<String?>(
                                          name: 'category',
                                          initialValue: [],
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          selectedColor: Theme.of(context).toggleableActiveColor,
                                          spacing: 4.0,
                                          decoration: InputDecoration(
                                            labelText:
                                                'Selecione as categorias',
                                            labelStyle: labelTextStyle,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          options:
                                              controller.listaCategoriasField(
                                                  kTipoMeditation) as List<FormBuilderFieldOption<String?>>,
                                          validator:FormBuilderValidators.required(context,
                                                errorText:'selecione pelo menos uma categoria'),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Theme.of(context)
                                                          .colorScheme.secondary),
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                            verticalSpaceSmall,
                            FormBuilderSwitch(
                              title: Text('Colocar Meditação em destaque?',
                                  style: hintFieldTextStyle),
                              name: 'featured',
                              activeColor: Theme.of(context).colorScheme.secondary,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 8, 12, 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              initialValue: false,
                            ),
                            verticalSpaceSmall,
                            Container(
                              padding: EdgeInsets.all(12),
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: OutlineButton(
                                color: accentColor,
                                onPressed: () => controller.selectAudio(),
                                child: Text('Selecionar Arquivo de áudio',
                                    style: hintFieldTextStyle),
                              ),
                            ),
                            verticalSpaceSmall,
                            controller.nameAudioFile == null
                                ? Container()
                                //? Text('Escolha o arquivo de audio',
                                //style: hintFieldTextStyle)
                                : Text(controller.nameAudioFile!,
                                    style: hintFieldTextStyle),
                            verticalSpaceSmall,
                            GestureDetector(
                              // When we tap we call selectImage
                              onTap: () async {
                                await controller.selectImage();
                                _novaImagem = true;
                                //print('selecionou nova imagem');
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 300,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondary.withAlpha(150),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: controller.selectedImage == null
                                      // If the selected image is null we show 'Tap to add post image'
                                      ? Text(
                                          'Toque para adicionar imagem à Meditação',
                                          style: TextStyle(
                                              color: Colors.grey[800]),
                                        )
                                      // acabou de selecionar imagem na galeria, então mostra imagemFile selecionada
                                      : Image.file(controller.selectedImage!)),
                            ),
                            verticalSpaceSmall,
                            Observer(
                              builder: (BuildContext context) {
                                return controller.selectedImage != null
                                    ? Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: MaterialButton(
                                              color:
                                                  Theme.of(context).colorScheme.secondary,
                                              child: Text(
                                                'Ajustar imagem',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                controller.cropImage();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: MaterialButton(
                                              color:
                                                  Theme.of(context).colorScheme.secondary,
                                              child: Text(
                                                'Cancelar ajuste',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                _fbKey.currentState!.reset();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container();
                              },
                            ),
                            FormBuilderTextField(
                              initialValue: '',
                              name: 'callText',
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText:
                                    'Texto curto de convite para meditação',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.max(context, 80),
                                FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              ]),
                            ),
                            verticalSpaceSmall,
                            FormBuilderTextField(
                              initialValue: '',
                              name: 'detailsText',
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: 'Texto explicativo da meditação',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              validator: FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
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
                              onPressed: () async {
                                if (await controller.audioFileNotOk()) return;

                                if (await controller.imageFileNotOk()) return;

                                _validaForm();
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
    });
  }

  void _validaForm() async {
    _fbKey.currentState!.save();
    if (_fbKey.currentState!.validate()) {
      print(_fbKey.currentState!.value);
      var form = _fbKey.currentState!.value;
      await controller.addDraftMeditation(
          title: form['title'],
          authorText: form['authorText'],
          authorMusic: form['authorMusic'],
          authorId: form['authorId'],
          callText: form['callText'],
          detailsText: form['detailsText'],
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          category: form['category'].cast<String>(),
          featured: form['featured'],
          novaImagem: _novaImagem);
    } else {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar a Meditação',
        description: 'Verifique erros de validação',
      );
    }
  }
}
