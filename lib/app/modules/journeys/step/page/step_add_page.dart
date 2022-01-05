import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../journey/helper/helper.dart';
import '../controller/step_add_controller.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

class StepAddPage extends StatefulWidget {
  final JourneyStepArgs args;

  const StepAddPage({ required this.args, Key? key,}) : super(key: key);

  @override
  _StepAddPageState createState() => _StepAddPageState();
}

class _StepAddPageState
    extends ModularState<StepAddPage, StepAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('New Step'),
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
                            StepNumberField(),          
                            verticalSpace(16),
                            DescriptionField(),
                            verticalSpace(16),
                            InspirationText(),
                            verticalSpace(8),
                            InspirationAudioField(controller: controller),
                            verticalSpace(8),
                            controller.nameInspirationAudioFile == null
                                ? Container()
                                : Text(controller.nameInspirationAudioFile!,style: hintFieldTextStyle),
                            verticalSpace(16),
                            MeditationText(),
                            verticalSpace(16),
                            MeditationAudioField(controller: controller),
                            verticalSpace(8),
                            controller.nameMeditationAudioFile == null
                                ? Container()
                                : Text(controller.nameMeditationAudioFile!,style: hintFieldTextStyle),
                            verticalSpace(16),
                            PracticeTextField(),
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
                                if (await controller.audioFileNotOk()) return;
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

  void _validateForm() async {
    _fbKey.currentState!.save();
    if (_fbKey.currentState!.validate()) {
      print(_fbKey.currentState!.value);
      var form = _fbKey.currentState!.value;
      await controller.addStep(
          journeyId: widget.args.journeyId,
          title: form['title'],
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          stepNumber: int.parse(form['stepNumber']),
          descriptionText: form['descriptionText'],
          inspirationText: form['inspirationText'],
          meditationText: form['meditationText'],
          practiceText: form['practiceText'],
          );
    } else {
      await _dialogService.showDialog(
        title: 'Was not possible to create this Step',
        description: 'Check errors',
      );
    }
  }
}

class MeditationText extends StatelessWidget {
  const MeditationText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: '',
      name: 'meditationText',
      maxLines: 8,
      decoration: InputDecoration(
        labelText: 'Meditation text',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: FormBuilderValidators.required(context,
            errorText: 'Required Field'),
    );
  }
}

class MeditationAudioField extends StatelessWidget {
  const MeditationAudioField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final StepAddController controller;

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

class InspirationText extends StatelessWidget {
  const InspirationText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: '',
      name: 'inspirationText',
      maxLines: 8,
      decoration: InputDecoration(
        labelText: 'Inspiration Text',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: FormBuilderValidators.required(context,
            errorText: 'Required Field'),
    );
  }
}

class InspirationAudioField extends StatelessWidget {
  const InspirationAudioField({Key? key,required this.controller,}) : super(key: key);

  final StepAddController controller;

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

class StepNumberField extends StatelessWidget {
  const StepNumberField({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'stepNumber',
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'Step Number',
        labelStyle: inputFieldTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: FormBuilderValidators.compose([
          FormBuilderValidators.numeric(context),
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
      initialValue: '',
      name: 'descriptionText',
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Tag line for this step',
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
            errorText: 'Required Field'),
    );
  }
}
