import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '/app/modules/meditation/draft_step/controller/draft_step_edit_controller.dart';
import '/app/modules/meditation/guided/model/step_model.dart';
import '/app/shared/utils/ui_utils.dart';

class DraftStepEditPage extends StatefulWidget {
  final StepModel? step;
  const DraftStepEditPage({Key? key, this.step}) : super(key: key);

  @override
  _DraftStepEditPageState createState() => _DraftStepEditPageState();
}

class _DraftStepEditPageState
    extends ModularState<DraftStepEditPage, DraftStepEditController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
                          'title': widget.step?.title ?? '',
                          'callText': widget.step!.callText ?? '',
                          'detailsText': widget.step!.detailsText ?? '',
                        },
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpace(16),
                            FormBuilderTextField(
                              name: 'title',
                              decoration: InputDecoration(
                                  labelText: 'Title',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.max(context,50),
                                  FormBuilderValidators.required(context,
                                      errorText: 'Informação obrigatória'),
                              ]),
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
                                    Text(widget.step!.audioFileName!),
                                  ]),
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
                              validator: FormBuilderValidators.required(context,
                                    errorText: 'Informação obrigatória'),
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
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                _fbKey.currentState!.save();
                                if (_fbKey.currentState!.validate()) {
                                  //print(_fbKey.currentState.value);
                                  var form = _fbKey.currentState!.value;
                                  controller.editDraftStep(
                                      title: form['title'],
                                      callText: form['callText'],
                                      detailsText: form['detailsText'],
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
              ),
      );
    });
  }
}
