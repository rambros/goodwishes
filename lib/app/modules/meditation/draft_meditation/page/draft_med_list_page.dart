import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '/app/modules/meditation/draft_meditation/controller/draft_med_list_controller.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

import 'draft_med_item.dart';

class DraftMeditationListPage extends StatefulWidget {
  const DraftMeditationListPage({Key? key}) : super(key: key);

  @override
  _DraftMeditationListPageState createState() => _DraftMeditationListPageState();
}

class _DraftMeditationListPageState
    extends ModularState<DraftMeditationListPage, DraftMeditationListController> {

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
        title: Text('Meditações em Edição'),
        // actions: <Widget>[
        //   IconButton(
        //     padding: EdgeInsets.only(right: 28.0),
        //     icon: Icon(Icons.search, size: 32.0 ),
        //     onPressed: () {
        //       controller.searchMeditation();
        //     },
        //   ),
        // ],
      ),
      //backgroundColor: Colors.white,
      floatingActionButton: (userRole == 'Admin')
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                controller.addMeditation();
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
                'Meditações em edição',
                style: titleTextStyle,
              ),
              _meditationsRecentes(controller),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}


Widget _meditationsRecentes(DraftMeditationListController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Material(
          //child: controller.meditations != null
          child: controller.draftMeditationsFiltered != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.draftMeditationsFiltered!.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showMeditationDetails(index),
                    child: DraftMeditationItem(
                      meditation: controller.draftMeditationsFiltered![index],
                      onDeleteItem: () => controller.deleteMeditation(index),
                      onPublishItem: () => controller.publishMeditation(index),
                      onEditItem: () => controller.editMeditation(index),
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
