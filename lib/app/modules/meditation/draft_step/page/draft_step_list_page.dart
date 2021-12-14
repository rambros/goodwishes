import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '/app/modules/meditation/draft_step/controller/draft_step_list_controller.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

import 'draft_step_item.dart';

class DraftStepListPage extends StatefulWidget {
  const DraftStepListPage({Key? key}) : super(key: key);

  @override
  _DraftStepListPageState createState() => _DraftStepListPageState();
}

class _DraftStepListPageState
    extends ModularState<DraftStepListPage, DraftStepListController> {

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = controller.getUserRole;
    return Scaffold(
      appBar: AppBar(
        title: Text('Managing Steps'),
      ),
      floatingActionButton: (userRole == 'Admin')
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                controller.addStep();
              })
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(8),
              Text(
                'Steps in draft mode',
                style: titleTextStyle,
              ),
              _stepsRecentes(controller),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}


Widget _stepsRecentes(DraftStepListController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Material(
          child: controller.DraftStepsFiltered != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.DraftStepsFiltered!.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showStepDetails(index),
                    child: DraftStepItem(
                      step: controller.DraftStepsFiltered![index],
                      onDeleteItem: () => controller.deleteStep(index),
                      onPublishItem: () => controller.publishStep(index),
                      onEditItem: () => controller.editStep(index),
                      userRole: userRole,
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
  );
}
