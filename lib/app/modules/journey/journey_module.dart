import 'package:flutter_modular/flutter_modular.dart';

import 'audio_player/audio_player_controller.dart';
import 'audio_player/audio_player_page.dart';
import 'draft_step/controller/draft_step_add_controller.dart';
import 'draft_step/controller/draft_step_details_controller.dart';
import 'draft_step/controller/draft_step_edit_controller.dart';
import 'draft_step/controller/draft_step_list_controller.dart';
import 'draft_step/page/draft_step_details_page.dart';
import 'draft_step/page/draft_step_edit_page.dart';
import 'draft_step/page/draft_step_list_page.dart';
import 'draft_step/page/draft_step_add_page.dart';
import 'step/controller/step_details_controller.dart';
import 'step/controller/step_edit_controller.dart';
import 'step/controller/step_list_controller.dart';
import 'step/controller/step_results_controller.dart';
import 'step/controller/step_search_controller.dart';
import 'step/page/step_details_page.dart';
import 'step/page/step_edit_page.dart';
import 'step/page/step_list_page.dart';
import 'step/page/step_results_page.dart';
import 'step/page/step_search_page.dart';
import 'journey_controller.dart';
import 'statistics/pages/statistics_page.dart';
import 'statistics/controller/statistics_controller.dart';
import 'statistics/repository/med_statistics_repository.dart';

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
        Bind((i) => JourneyController()),
        Bind((i) => StepListController()),
        Bind((i) => StepEditController()),
        Bind((i) => StepDetailsController()),
        Bind((i) => StepSearchController()),
        Bind((i) => StepResultsController()),

        Bind((i) => DraftStepListController()),
        Bind((i) => DraftStepAddController()),
        Bind((i) => DraftStepEditController()),
        Bind((i) => DraftStepDetailsController()),

        Bind((i) => MeditationStatisticsRepository()),
        Bind((i) => StatisticsController()),
      ];

  @override
  List<ModularRoute> get routes => [
        //ChildRoute('/', child: (_, args) => StepPage()),
        ChildRoute('/', child: (_, args) => StepListPage()),
        ChildRoute('/list', child: (_, args) => StepListPage()),
        ChildRoute('/details', child: (_, args) => StepDetailsPage(step: args.data)),
        ChildRoute('/edit', child: (_, args) => StepEditPage(step: args.data)),
        ChildRoute('/search', child: (_, args) => StepSearchPage()),
        ChildRoute('/audio_player', child: (_, args) => AudioPlayerPage(args: args.data)),
        ChildRoute('/results', child: (_, args) => StepResultsPage(steps: args.data)),

        ChildRoute('/draft/list', child: (_, args) => DraftStepListPage()),
        ChildRoute('/draft/add', child: (_, args) => DraftStepAddPage()),
        ChildRoute('/draft/edit', child: (_, args) => DraftStepEditPage(step: args.data)),
        ChildRoute('/draft/details', child: (_, args) => DraftStepDetailsPage(step: args.data)),

        ChildRoute('/statistics', child: (_, args) => StatisticsPage()),
      ];
}
