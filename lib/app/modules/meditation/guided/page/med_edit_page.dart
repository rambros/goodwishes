import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '/app/modules/category/category_model.dart';
import '/app/modules/meditation/guided/controller/med_edit_controller.dart';
import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/get_image_url.dart';

class MeditationEditPage extends StatefulWidget {
  final Meditation? meditation;
  const MeditationEditPage({Key? key, this.meditation}) : super(key: key);

  @override
  _MeditationEditPageState createState() => _MeditationEditPageState();
}

class _MeditationEditPageState
    extends ModularState<MeditationEditPage, MeditationEditController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _novaImagem = false;

    controller.changeSelectImage(null);
    controller.setEdittingMeditation(widget.meditation);

    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blueAccent,
          title: Text('Editar Meditação'),
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
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'title': widget.meditation?.title ?? '',
                          'category': widget.meditation!.category ?? '',
                          'featured': widget.meditation!.featured ?? '',
                          'callText': widget.meditation!.callText ?? '',
                          'detailsText': widget.meditation!.detailsText ?? '',
                          'authorId': widget.meditation!.authorId ?? '',
                        },
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpace(16),
                            FormBuilderTextField(
                              name: 'title',
                              decoration: InputDecoration(
                                  labelText: 'Título',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: FormBuilderValidators.compose([
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
                                  )),
                              hint: Text('Selecione o autor'),
                              validator: FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              items: controller.getListAuthors(),
                            ),

                            verticalSpaceSmall,

                            Observer(
                              builder: (BuildContext context) {
                                return Center(
                                  child: controller.hasCategories != null
                                      ? FormBuilderFilterChip(
                                          name: 'category',
                                          backgroundColor:
                                              Theme.of(context).colorScheme.secondary,
                                          selectedColor: Theme.of(context)
                                              .toggleableActiveColor,
                                          spacing: 4.0,
                                          decoration: InputDecoration(
                                              labelText:
                                                  'Selecione uma ou mais categorias',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              )),
                                          options:
                                              controller.listaCategoriasField(
                                                  kTipoMeditation),
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
                              title: Text('Colocar Meditação em destaque?'),
                              name: 'featured',
                              activeColor: Theme.of(context).colorScheme.secondary,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 8, 12, 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Arquivo de Áudio:'),
                                    Text(widget.meditation!.audioFileName!),
                                  ]),
                            ),

                            // Divider(
                            //   thickness: 2,
                            // ),
                            //imagem da publicação
                            //Text('Imagem da publicação'),
                            verticalSpaceSmall,
                            Observer(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  // When we tap we call selectImage
                                  onTap: () async {
                                    await controller.selectImage();
                                    _novaImagem = true;
                                  },
                                  child: Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      child: controller.selectedImage == null
                                          ? GetImageUrl(
                                              imageUrl:
                                                  widget.meditation!.imageUrl)
                                          : Image.file(
                                              controller.selectedImage!)),
                                );
                              },
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
                            verticalSpaceSmall,
                            FormBuilderTextField(
                              name: 'callText',
                              maxLines: 5,
                              decoration: InputDecoration(
                                  labelText: 'Texto de convite para meditação',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.max(context, 80),
                                FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              ]),
                            ),
                            verticalSpaceSmall,
                            FormBuilderTextField(
                              name: 'detailsText',
                              maxLines: 5,
                              decoration: InputDecoration(
                                  labelText: 'Texto de detalhes da meditação',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
                              ]),
                            ),
                            verticalSpaceMedium,
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
                                  //print(_fbKey.currentState.value);
                                  var form = _fbKey.currentState!.value;
                                  controller.editMeditation(
                                      title: form['title'],
                                      authorId: form['authorId'],
                                      callText: form['callText'],
                                      detailsText: form['detailsText'],
                                      category: form['category'].cast<String>(),
                                      featured: form['featured'],
                                      novaImagem: _novaImagem);
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
              ),
      );
    });
  }
}
