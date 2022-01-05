// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../controller/journey_add_controller.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

class JourneyAddPage extends StatefulWidget {
  const JourneyAddPage({
    Key? key,
  }) : super(key: key);

  @override
  _JourneyAddPageState createState() => _JourneyAddPageState();
}

class _JourneyAddPageState
    extends ModularState<JourneyAddPage, JourneyAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('New Journey'),
        ),
        body: controller.busy
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Please await processing files'),
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
                            TitleField(),
                            verticalSpace(16),
                            DescriptionField(),
                            verticalSpace(16),
                            ImageField(controller: controller),
                            verticalSpace(8),
                            adjustImage(),
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
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                _validateForm();
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
                                'Cancel',
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

  Observer adjustImage() {
    return Observer(
        builder: (BuildContext context) {
          return controller.selectedImage != null
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color:
                            Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Adjust image',
                          style: TextStyle(
                              color: Colors.white),
                        ),
                        onPressed: () {
                          controller.cropImage();
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: MaterialButton(
                        color:
                            Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Cancel',
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
      );
  }

  void _validateForm() async {
    _fbKey.currentState!.save();
    if (_fbKey.currentState!.validate()) {
      print(_fbKey.currentState!.value);
      var form = _fbKey.currentState!.value;
      await controller.addJourney(
          title: form['title'],
          description: form['descriptionText'],
          );
    } else {
      await _dialogService.showDialog(
        title: 'Was not possible to create this Journey',
        description: 'Check errors',
      );
    }
  }
}

class ImageField extends StatelessWidget {
  const ImageField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final JourneyAddController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.selectImage();
        controller.setNewImage(true);
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
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: '',
      name: 'descriptionText',
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Small description of this Journey',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: FormBuilderValidators.required(context,
            errorText: 'Required Field'),
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'title',
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'Title',
        labelStyle: inputFieldTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: FormBuilderValidators.compose([
          FormBuilderValidators.max(context,50),
          FormBuilderValidators.required(context,
              errorText: 'Required Field'),
      ]),
    );
  }
}
