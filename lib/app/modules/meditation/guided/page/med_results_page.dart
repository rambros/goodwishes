import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '/app/modules/meditation/guided/controller/med_results_controller.dart';
import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/utils/ui_utils.dart';

import 'med_item.dart';

class MeditationResultsPage extends StatefulWidget {
  final List<Meditation>? meditations;
  const MeditationResultsPage({Key? key, this.meditations}) : super(key: key);

  @override
  _MeditationResultsPageState createState() => _MeditationResultsPageState();
}

class _MeditationResultsPageState
    extends ModularState<MeditationResultsPage, MeditationResultsController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    controller.init(widget.meditations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado da pesquisa'),
        // leading: IconButton(
        //   icon: new Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: new Icon(Icons.search),
        //     onPressed: () {
        //       controller.searchMeditation();
        //     },
        //   ),
        //   IconButton(
        //       icon: Icon(Icons.highlight_off),
        //       onPressed: () {
        //         //controller.logoff();
        //       }),
        // ],
      ),
      backgroundColor: Colors.white,
      //floatingActionButton: (controller.getUserRole == "Admin")
      floatingActionButton: (true)
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                controller.addMeditation();
              })
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: controller.meditations!.isEmpty
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
                    'Meditações encontradas: ${controller.meditations!.length}',
                    style: TextStyle(fontSize: 24),
                  ),
                  Observer(
                    builder: (BuildContext context) {
                      return Expanded(
                          child: widget.meditations != null
                              ? ListView.builder(
                                  itemCount: controller.meditations!.length,
                                  padding: EdgeInsets.only(top: 5.0),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () =>
                                        controller.showMeditationDetails(index),
                                    child: MeditationItem(
                                      meditation: controller.meditations![index],
                                      onChangeStatusItem: () =>
                                          controller.changeStatusToDraft(index),
                                      onEditItem: () =>
                                          controller.editMeditation(index),
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
