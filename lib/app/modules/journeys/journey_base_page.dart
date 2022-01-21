import 'package:flutter/material.dart';

import 'journey/journey.dart';
import 'user_journey/user_journey.dart';

class JourneyBasePage extends StatefulWidget {
  const JourneyBasePage({Key? key}) : super(key: key);

  @override
  _JourneyBasePageState createState() => _JourneyBasePageState();
}

class _JourneyBasePageState extends State<JourneyBasePage> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(text: 'My Journeys'),
    Tab(text: 'Available Journeys'),
  ];

  JourneyListController journeyListController = JourneyListController();
  UserJourneyListCubit userJourneyListCubit = UserJourneyListCubit();

  TabController? _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    journeyListController.init();
    userJourneyListCubit.init();
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
               UserJourneyList(userJourneyListCubit),
               JourneyList(journeyListController),
            ],
        ),
      ),
        );
  }
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

