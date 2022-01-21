import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import './../../helper/helper.dart';
import '../controller/step_edit_controller.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

class StepEditPage extends StatefulWidget {
  final JourneyStepArgs args;
  const StepEditPage({Key? key, required this.args}) : super(key: key);

  @override
  _StepEditPageState createState() => _StepEditPageState();
}

class _StepEditPageState
    extends ModularState<StepEditPage, StepEditController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();

  @override
  void initState() {
    controller.setOldStep(widget.args.step!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          'title': widget.args.step?.title ?? '',
                          'stepNumber': widget.args.step!.stepNumber.toString(),
                          'descriptionText': widget.args.step!.descriptionText ?? '',
                          'inspirationText': widget.args.step!.inspirationText,
                          'meditationText': widget.args.step!.meditationText,
                          'practiceText': widget.args.step!.practiceText,

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
                            showOldInspirationAudioFile(),
                            verticalSpace(8),
                            InspirationAudioField(controller: controller),
                            verticalSpace(8),
                            controller.nameInspirationAudioFile == null
                                ? Container()
                                : Text(controller.nameInspirationAudioFile!,style: hintFieldTextStyle),
                            verticalSpace(16),

                            MeditationTextField(),
                            verticalSpace(16),
                            showOldMeditationAudioFile(),
                            verticalSpace(8),
                            MeditationAudioField(controller: controller),
                            verticalSpace(8),
                            controller.nameMeditationAudioFile == null
                                ? Container()
                                : Text(controller.nameMeditationAudioFile!,style: hintFieldTextStyle),
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

  Widget showOldInspirationAudioFile() {
    return Text('Old Inspiration audio file: ${widget.args.step!.inspirationFileName}');
  }

  Widget showOldMeditationAudioFile() {
    return Text('Old Meditation audio file: ${widget.args.step!.meditationFileName}');
  }

  void _validateForm() async {
    _fbKey.currentState!.save();
    if (_fbKey.currentState!.validate()) {
      var form = _fbKey.currentState!.value;
      await controller.editStep(
          journeyId: widget.args.journeyId,
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

class InspirationAudioField extends StatelessWidget {
  const InspirationAudioField({Key? key,required this.controller,}) : super(key: key);

  final StepEditController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          //backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => controller.selectInspirationAudio(),
        child: Text('Select inspiration audio file',
            style: hintFieldTextStyle),
      ),
    );
  }
}

class MeditationAudioField extends StatelessWidget {
  const MeditationAudioField({Key? key,required this.controller,}) : super(key: key);

  final StepEditController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          //backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => controller.selectMeditationAudio(),
        child: Text('Select meditation audio file',
            style: hintFieldTextStyle),
      ),
    );
  }
}

