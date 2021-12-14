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
import 'guided/controller/med_details_controller.dart';
import 'guided/controller/med_edit_controller.dart';
import 'guided/controller/med_list_controller.dart';
import 'guided/controller/med_results_controller.dart';
import 'guided/controller/med_search_controller.dart';
import 'guided/page/med_course_page.dart';
import 'guided/page/med_details_page.dart';
import 'guided/page/med_edit_page.dart';
import 'guided/page/med_list_page.dart';
import 'guided/page/med_results_page.dart';
import 'guided/page/med_video_list_page.dart';
import 'guided/page/meditation_search_page.dart';
import 'meditation_controller.dart';
import 'timer/controller/timer_controller.dart';
import 'timer/controller/timer_end_sound_sel_controller.dart';
import 'timer/controller/timer_music_sel_controller.dart';
import 'timer/controller/timer_player_controller.dart';
import 'timer/controller/timer_service.dart';
import 'timer/controller/timer_start_sound_sel_controller.dart';
import 'timer/page/timer_end_sound_sel_page.dart';
import 'timer/page/timer_player_page.dart';
import 'timer/page/timer_start_sound_sel_page.dart';
import 'timer/page/timer_music_sel_page.dart';
import 'timer/page/timer_page.dart';
import 'timer/repository/timer_music_repository.dart';
import 'statistics/pages/statistics_page.dart';
import 'statistics/controller/statistics_controller.dart';
import 'statistics/repository/med_statistics_repository.dart';

class MeditationModule extends Module {
  @override
  List<Bind> get binds => [
        // declarados no home_module
        // Bind((i) => CategoryController()),
        // Bind((i) => CategoryListController()),
        // Bind((i) => SearchController()),
        // Bind((i) => AccountController()),
        Bind((i) => AudioPlayerController()),

        //Bind((i) => MeditationFirebaseRepository()),
        Bind((i) => MeditationController()),
        Bind((i) => MeditationListController()),
        Bind((i) => MeditationEditController()),
        Bind((i) => MeditationDetailsController()),
        Bind((i) => MeditationSearchController()),
        Bind((i) => MeditationResultsController()),

        Bind((i) => DraftStepListController()),
        Bind((i) => DraftStepAddController()),
        Bind((i) => DraftStepEditController()),
        Bind((i) => DraftStepDetailsController()),

        Bind((i) => TimerController()),
        Bind((i) => TimerMusicSelController()),
        Bind((i) => TimerStartSoundSelController()),
        Bind((i) => TimerEndSoundSelController()),
        Bind((i) => TimerPlayerController()),
        Bind((i) => TimerMusicRepository()),
        Bind((i) => TimerService()),

        Bind((i) => MeditationStatisticsRepository()),
        Bind((i) => StatisticsController()),
      ];

  @override
  List<ModularRoute> get routes => [
        //ChildRoute('/', child: (_, args) => MeditationPage()),
        ChildRoute('/', child: (_, args) => MeditationListPage()),
        ChildRoute('/list', child: (_, args) => MeditationListPage()),
        ChildRoute('/details', child: (_, args) => MeditationDetailsPage(meditation: args.data)),
        ChildRoute('/edit', child: (_, args) => MeditationEditPage(meditation: args.data)),
        ChildRoute('/search', child: (_, args) => MeditationSearchPage()),
        //ChildRoute('/audio_player', child: (_, args) => ServicePlayerPage(model: args.data)),
        ChildRoute('/audio_player', child: (_, args) => AudioPlayerPage(model: args.data)),
        ChildRoute('/results', child: (_, args) => MeditationResultsPage(meditations: args.data)),

        ChildRoute('/draft/list', child: (_, args) => DraftStepListPage()),
        ChildRoute('/draft/add', child: (_, args) => DraftStepAddPage()),
        ChildRoute('/draft/edit', child: (_, args) => DraftStepEditPage(step: args.data)),
        ChildRoute('/draft/details', child: (_, args) => DraftStepDetailsPage(step: args.data)),

        ChildRoute('/timer', child: (_, args) => TimerPage()),
        ChildRoute('/timer_player', child: (_, args) => TimerPlayerPage(timerModel: args.data)),
        ChildRoute('/timer/music/selection', child: (_, args) => TimerMusicSelectionPage()),
        ChildRoute('/timer/end_sound/selection', child: (_, args) => TimerEndSoundSelectionPage()),
        ChildRoute('/timer/start_sound/selection', child: (_, args) => TimerStartSoundSelectionPage()),

        ChildRoute('/statistics', child: (_, args) => StatisticsPage()),
        
        ChildRoute('/course', child: (_, args) => MeditationCoursePage()),
        ChildRoute('/video/list', child: (_, args) => MeditationVideoListPage()),
      ];

}
