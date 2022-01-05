import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../controller/journey_list_controller.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

import 'journey_item.dart';

class JourneyListPage extends StatefulWidget {
  const JourneyListPage({Key? key}) : super(key: key);

  @override
  _JourneyListPageState createState() => _JourneyListPageState();
}

class _JourneyListPageState
    extends ModularState<JourneyListPage, JourneyListController> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(text: 'My Journeys'),
    Tab(text: 'Available Journeys'),
  ];

  TabController? _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    controller.init();
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = controller.getUserRole;
    return Scaffold(
      appBar: AppBar(
        title: Text('Journeys'),
      ),
      floatingActionButton: (userRole == 'Admin')
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                controller.addJourney();
              })
          : null,      
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Center(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  isScrollable: true,
                  tabs: myTabs,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
             controller: _tabController,
             children: [
               Text('some content'), 
               _listJourneys(controller),
            ],
        ),
      ),
        );
  }
}
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.max,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         verticalSpace(8),
      //         _tabViewJourney(context, controller),
      //         //_listJourneys(controller),
      //       ],
      //     ),
      //   ),
      // ),
      // ),
//     );
//   }
// }

Widget _listJourneys(JourneyListController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Material(
          child: controller.journeys != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.journeys!.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showJourneyDetails(index),
                    child: JourneyItem(
                      journey: controller.journeys![index],
                      onDeleteItem: () => controller.deleteJourney(index),
                      onPublishItem: () {},
                      onEditItem: () => controller.editJourney(index),
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

Widget _tabViewJourney(BuildContext context,JourneyListController controller ) {
 return SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  //labelStyle: Theme.of(context).bodyText1,
                  //indicatorColor: Theme.of(context).secondaryColor,
                  tabs: [
                    Tab(
                      text: 'My Journeys',
                    ),
                    Tab(
                      text: 'Available Journeys',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Text(
                        'Tab View 1',
                      ),
                      _listJourneys(controller),
                    ],
                  ),
                ),
              ],
            ),
  ),
 ),
 );
}

