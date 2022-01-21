import 'package:flutter_modular/flutter_modular.dart';

import 'audio_player/audio_player_controller.dart';
import 'audio_player/audio_player_page.dart';
import 'journey/journey.dart';
import 'journey_base_page.dart';
import 'step/controller/step_add_controller.dart';
import 'step/controller/step_details_controller.dart';
import 'step/controller/step_edit_controller.dart';
import 'step/controller/step_list_controller.dart';
import 'step/page/step_add_page.dart';
import 'step/page/step_details_page.dart';
import 'step/page/step_edit_page.dart';
import 'statistics/pages/statistics_page.dart';
import 'statistics/controller/statistics_controller.dart';
import 'statistics/repository/med_statistics_repository.dart';
import 'user_journey/user_journey.dart';
import 'user_step/controller/user_step_details_controller.dart';
import 'user_step/page/user_step_details_page.dart';

class JourneyModule extends Module {
  @override
  List<Bind> get binds => [
        // declarados no home_module
        // Bind((i) => CategoryController()),
        // Bind((i) => CategoryListController()),
        // Bind((i) => SearchController()),
        // Bind((i) => AccountController()),
        Bind((i) => AudioPlayerController()),

        //Bind((i) => StepFirebaseRepository()),
        Bind((i) => FirebaseUserJourneyRepository()),
        Bind((i) => JourneyListController()),
        Bind((i) => JourneyAddController()),
        Bind((i) => JourneyEditController()),
        Bind((i) => JourneyDetailsController()),

        Bind((i) => UserJourneyListCubit()),
        Bind((i) => UserJourneyDetailsController()),

        Bind((i) => StepListController()),
        Bind((i) => StepAddController()),
        Bind((i) => StepEditController()),
        Bind((i) => StepDetailsController()),

        Bind((i) => UserStepDetailsController()),

        Bind((i) => MeditationStatisticsRepository()),
        Bind((i) => StatisticsController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => JourneyBasePage()),
        ChildRoute('/add', child: (_, args) => JourneyAddPage()),
        ChildRoute('/edit', child: (_, args) => JourneyEditPage(journey: args.data)),
        ChildRoute('/details', child: (_, args) => JourneyDetailsPage(journey: args.data)),

        ChildRoute('/user_journey/details', child: (_, args) => UserJourneyDetailsPage(userJourney: args.data)),

        ChildRoute('/step/add', child: (_, args) => StepAddPage(args: args.data)),
        ChildRoute('/step/edit', child: (_, args) => StepEditPage(args: args.data)),
        ChildRoute('/step/details', child: (_, args) => StepDetailsPage(args: args.data)),

        ChildRoute('/user_step/details', child: (_, args) => UserStepDetailsPage(args: args.data)),
        
        ChildRoute('/audio_player', child: (_, args) => AudioPlayerPage(args: args.data)),
        ChildRoute('/statistics', child: (_, args) => StatisticsPage()),
      ];
}
