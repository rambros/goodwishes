import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller/step_list_controller.dart';
import '/app/shared/widgets/page_bar_widget.dart';
import '/app/shared/utils/shared_styles.dart';

import 'step_item.dart';

class StepListPage extends StatefulWidget {
  const StepListPage({Key? key}) : super(key: key);

  @override
  _StepListPageState createState() => _StepListPageState();
}

class _StepListPageState
    extends ModularState<StepListPage, StepListController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = controller.getUserRole;
    return Scaffold(
      appBar: PageBar(title: 'Journey'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              userRole == 'Admin' 
              ? ManageSteps() 
              : Text(
                'Start your journey to master good wishes',
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

class ManageSteps extends StatelessWidget {
  const ManageSteps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 14),
        primary: Theme.of(context).colorScheme.primary,
        onPrimary: Theme.of(context).colorScheme.onPrimary,
      elevation: 2,
      ),
      onPressed: () {
        Modular.to.pushNamed('/journey/draft/list');
      },
      child: Text('Manager Steps - only for Admins'.toUpperCase()),
    );
  }
}

Widget _stepsRecentes(StepListController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Container(
          child: controller.stepsFiltered != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.stepsFiltered.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showStepDetails(index),
                    child: StepItem(
                      step: controller.stepsFiltered[index],
                      onChangeStatusItem: () => controller.changeStatusToDraft(index),
                      onEditItem: () => controller.editStep(index),
                      onPlayItem: () => controller.showStepDetails(index),
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
