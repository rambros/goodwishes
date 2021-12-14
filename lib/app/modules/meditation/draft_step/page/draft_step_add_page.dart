import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '/app/modules/meditation/draft_step/controller/draft_step_add_controller.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/color.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

class DraftStepAddPage extends StatefulWidget {
  const DraftStepAddPage({
    Key? key,
  }) : super(key: key);

  @override
  _DraftStepAddPageState createState() => _DraftStepAddPageState();
}

class _DraftStepAddPageState
    extends ModularState<DraftStepAddPage, DraftStepAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _dialogService = Modular.get<DialogService>();
  bool _novaImagem = false;

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
                            FormBuilderTextField(
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
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (await controller.audioFileNotOk()) return;

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

  void _validaForm() async {
    _fbKey.currentState!.save();
    if (_fbKey.currentState!.validate()) {
      print(_fbKey.currentState!.value);
      var form = _fbKey.currentState!.value;
      await controller.addDraftStep(
          title: form['title'],
          callText: form['callText'],
          detailsText: form['detailsText'],
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
    } else {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar a Meditação',
        description: 'Verifique erros de validação',
      );
    }
  }
}
