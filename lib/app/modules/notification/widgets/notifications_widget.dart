import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '/app/modules/notification/controller/notification_controller.dart';

import '../../../shared/utils/empty_page.dart';
import '../../../shared/utils/loading_card.dart';

import 'notification_card.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends ModularState< NotificationsWidget, NotificationController> {

  ScrollController? _scrollController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0))
    .then((value){
      _scrollController = ScrollController()..addListener(_scrollListener);
      controller.onRefresh();
    });
  }


  @override
  void dispose() {
    _scrollController!.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() async {
    await controller.getData();
    if (!controller.isLoading) {
      if (_scrollController!.position.pixels == _scrollController!.position.maxScrollExtent) {
        controller.setLoading(true);
        await controller.getData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) { 
        return controller.hasData == true 
          ? RefreshIndicator(
              color: Theme.of(context).accentColor,
              child: ListView.separated(
                  padding: EdgeInsets.all(15),
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.data.isNotEmpty ? controller.data.length + 1 : 8,
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15,),
                  itemBuilder: (_, int index) {
                    if (index < controller.data.length) {
                      return NotificationCard(d: controller.data[index]);
                    }
                    return Opacity(
                        opacity: controller.isLoading ? 1.0 : 0.0,
                        child: controller.lastVisible == null
                        ? LoadingCard(height: 150)
                        : Center(
                            child: SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: CupertinoActivityIndicator()),
                        ),
                    );
                  },
              ),
              onRefresh: () async {
                controller.onRefresh();
              },
            )
          : ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.35,),
                EmptyPage(icon: Icons.calendar_today, message: 'Nenhuma Notificação', message1: ''),
              ],
            );
      },
    );
  }
}

