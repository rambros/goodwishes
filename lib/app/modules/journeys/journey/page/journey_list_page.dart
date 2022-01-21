import 'package:flutter/material.dart';

import '../journey.dart';

class JourneyListPage extends StatefulWidget {
  const JourneyListPage({Key? key}) : super(key: key);

  @override
  _JourneyListPageState createState() => _JourneyListPageState();
}

class _JourneyListPageState extends State<JourneyListPage> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(text: 'My Journeys'),
    Tab(text: 'Available Journeys'),
  ];

  JourneyListController journeyListController = JourneyListController();

  TabController? _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    journeyListController.init();
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
    final userRole = journeyListController.getUserRole;
    return Scaffold(
      appBar: AppBar(
        title: Text('Journeys'),
      ),
      floatingActionButton: (userRole == 'Admin')
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: !journeyListController.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                journeyListController.addJourney();
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
               JourneyList(journeyListController),
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
                      JourneyList(controller),
                    ],
                  ),
                ),
              ],
            ),
  ),
 ),
 );
}

