import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'agenda_controller.dart';
import 'agenda_page.dart';
import 'controller/event_details_controller.dart';
import 'controller/event_list_controller.dart';
import 'controller/event_registration_controller.dart';
import 'controller/site_list_controller.dart';
import 'page/agenda_list_page.dart';
import 'page/event_details_page.dart';
import 'page/event_list_page.dart';
import 'page/event_registration_page.dart';


class AgendaModule extends Module {
  @override
  final List<Bind> binds = [
        // Bind((i) => CategoryController()),
        Bind((i) => AgendaController()),
        Bind((i) => EventListController()),
        Bind((i) => SiteListController()),
        Bind((i) => EventDetailsController()),
        Bind((i) => EventRegistrationController()),
      ];

  Widget get view => AgendaPage(); 

  @override
  final List<ChildRoute> routes = [
        ChildRoute('/', child: (_, args) => AgendaPage()),
        ChildRoute('/list', child: (_, args) => AgendaListPage()),
        ChildRoute('/event/list', child: (_, args) => EventListPage()),
        ChildRoute('/event/registration', child: (_, args) => EventRegistrationPage()),
        ChildRoute('/event/details', child: (_, args) => EventDetailsPage(event: args.data)),
      ];

  //static Inject get to => Inject<AgendaModule>.of();
}
