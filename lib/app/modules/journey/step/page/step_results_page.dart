import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '/app/modules/journey/model/step_model.dart';
import '../controller/step_results_controller.dart';
import '/app/shared/utils/ui_utils.dart';
import 'step_item.dart';

class StepResultsPage extends StatefulWidget {
  final List<StepModel>? steps;
  const StepResultsPage({Key? key, this.steps}) : super(key: key);

  @override
  _StepResultsPageState createState() => _StepResultsPageState();
}

class _StepResultsPageState
    extends ModularState<StepResultsPage, StepResultsController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    controller.init(widget.steps);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado da pesquisa'),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: (true)
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                controller.addStep();
              })
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: controller.steps!.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  verticalSpace(35),
                  Text(
                    'Nenhuma Meditação encontrada',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  verticalSpace(35),
                  Text(
                    'Meditações encontradas: ${controller.steps!.length}',
                    style: TextStyle(fontSize: 24),
                  ),
                  Observer(
                    builder: (BuildContext context) {
                      return Expanded(
                          child: widget.steps != null
                              ? ListView.builder(
                                  itemCount: controller.steps!.length,
                                  padding: EdgeInsets.only(top: 5.0),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () =>
                                        controller.showStepDetails(index),
                                    child: StepItem(
                                      step: controller.steps![index],
                                      onChangeStatusItem: () =>
                                          controller.changeStatusToDraft(index),
                                      onEditItem: () =>
                                          controller.editStep(index),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ));
                    },
                  )
                ],
              ),
      ),
    );
  }
}
