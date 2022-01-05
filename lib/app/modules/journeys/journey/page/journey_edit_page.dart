import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../controller/journey_edit_controller.dart';
import '/app/modules/journeys/model/models.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/get_image_url.dart';

class JourneyEditPage extends StatefulWidget {
  final Journey? journey;
  const JourneyEditPage({Key? key, this.journey}) : super(key: key);

  @override
  _JourneyEditPageState createState() => _JourneyEditPageState();
}

class _JourneyEditPageState
    extends ModularState<JourneyEditPage, JourneyEditController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.setEdittingJourney(widget.journey!);

    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Journey'),
        ),
        body: controller.busy
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Wait while files are processing..'),
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
                          'title': widget.journey?.title ?? '',
                          'description': widget.journey!.description ?? '',
                        },
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpace(16),
                            TitleField(),
                            verticalSpace(16),
                            DescriptionField(),
                            verticalSpace(16),
                            ImageField(controller: controller, widget: widget,),
                            verticalSpaceSmall,
                            adjustImage(),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
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

  Observer adjustImage() {
    return Observer(
      builder: (BuildContext context) {
        return controller.selectedImage != null
            ? Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color:Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Crop image',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.cropImage();
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Cancel',
                        style: TextStyle( color: Colors.white),
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
      var form = _fbKey.currentState!.value;
      await controller.editJourney(
          title: form['title'],
          description: form['description'],
          imageUrl: widget.journey!.imageUrl,
          imageFileName: widget.journey!.imageFileName,
        );
    } else {
      await _dialogService.showDialog(
        title: 'Was not possible to update this Journey',
        description: 'Check errors',
      );
    }
  }
}

class ImageField extends StatelessWidget {
  const ImageField({
    Key? key,
    required this.controller,
    required this.widget,
  }) : super(key: key);

  final JourneyEditController controller;
  final JourneyEditPage widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.selectImage();
        controller.setNewImage(true);
      },
      child: Container(
          height: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: controller.selectedImage == null
              ? GetImageUrl(
                  imageUrl: widget.journey!.imageUrl)
              : Image.file(
                  controller.selectedImage!)),
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'title',
      decoration: InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context,
            errorText: 'Required Field'),
      ]),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'description',
      maxLines: 5,
      decoration: InputDecoration(
          labelText: 'Description of this Journey',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.max(context, 300),
        FormBuilderValidators.required(context,
            errorText: 'Required Field'),
      ]),
    );
  }
}
