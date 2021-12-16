import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../controller/step_edit_controller.dart';
import '/app/modules/journey/model/step_model.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/ui_utils.dart';

class StepEditPage extends StatefulWidget {
  final StepModel? step;
  const StepEditPage({Key? key, this.step}) : super(key: key);

  @override
  _StepEditPageState createState() => _StepEditPageState();
}

class _StepEditPageState
    extends ModularState<StepEditPage, StepEditController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.setEdittingStep(widget.step);

    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Step'),
        ),
        body: controller.busy
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Wait while the files are saved'),
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
                          'title': widget.step?.title ?? '',
                          'stepNumber': widget.step!.stepNumber,
                          'descriptionText': widget.step!.descriptionText ?? '',
                          'inspirationText': widget.step!.inspirationText,
                          'meditationText': widget.step!.meditationText,
                          'practiceText': widget.step!.practiceText,
                        },
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpace(16),
                            TitleField(),
                            verticalSpace(16),
                            StepNumberField(),
                            verticalSpace(16),
                            DescriptionField(),
                            verticalSpace(16),
                            InspirationTextField(),
                            verticalSpace(16),
                            MeditationTextField(),
                            verticalSpace(16),
                            PracticeTextField(),
                            verticalSpace(16),
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

  void _validateForm() async {
    _fbKey.currentState!.save();
    if (_fbKey.currentState!.validate()) {
      var form = _fbKey.currentState!.value;
      await controller.editStep(
          title: form['title'],
          stepNumber: form['stepNumber'],
          descriptionText: form['descriptionText'],
          inspirationText: form['inspirationText'],
          meditationText: form['meditationText'],
          practiceText: form['practiceText'],
        );
    } else {
      await _dialogService.showDialog(
        title: 'Was not possible to update this Step',
        description: 'Check errors',
      );
    }
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

class StepNumberField extends StatelessWidget {
  const StepNumberField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'stepNumber',
      decoration: InputDecoration(
          labelText: 'Step Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.compose([
          FormBuilderValidators.integer(context),
          FormBuilderValidators.max(context,2),
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
      name: 'descriptionText',
      maxLines: 5,
      decoration: InputDecoration(
          labelText: 'tag line for this step',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.max(context, 80),
        FormBuilderValidators.required(context,
            errorText: 'Informação obrigatória'),
      ]),
    );
  }
}


class MeditationTextField extends StatelessWidget {
  const MeditationTextField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'meditationText',
      maxLines: 8,
      decoration: InputDecoration(
          labelText: 'Meditation Text',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.required(context,
            errorText: 'Informação obrigatória'),
    );
  }
}

class InspirationTextField extends StatelessWidget {
  const InspirationTextField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'inspirationText',
      maxLines: 8,
      decoration: InputDecoration(
          labelText: 'Inspiration Text',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.required(context,
            errorText: 'Informação obrigatória'),
    );
  }
}


class PracticeTextField extends StatelessWidget {
  const PracticeTextField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'practiceText',
      maxLines: 8,
      decoration: InputDecoration(
          labelText: 'Practice Text',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      validator: FormBuilderValidators.required(context,
            errorText: 'Informação obrigatória'),
    );
  }
}

