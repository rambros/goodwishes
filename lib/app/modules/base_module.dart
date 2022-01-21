import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/base_controller.dart';

import '../shared/reminder/alarm.dart';
import '../shared/settings/settings_page.dart';

import 'autentica/page/privacy_police_page.dart';
import 'base_page.dart';
import 'community/community_controller.dart';
import 'community/community_module.dart';
import 'config/controller/account_controller.dart';
import 'config/controller/delete_account_controller.dart';
import 'config/pages/account_page.dart';
import 'config/pages/avalia_app_page.dart';
import 'config/pages/config_page.dart';
import 'config/pages/delete_account_page.dart';
import 'config/pages/about_app_page.dart';
import 'config/pages/invite_page.dart';
import 'config/pages/donation_page.dart';
import 'config/pages/feature_page.dart';
import 'config/pages/feedback_page.dart';
import 'config/pages/support_page.dart';
import 'fundamentals/fundamentals_module.dart';
import 'journeys/draft_step/repository/draft_step_firebase_controller.dart';
import 'journeys/draft_step/repository/draft_step_firebase_repository.dart';
import 'journeys/journey/controller/journey_list_controller.dart';
import 'journeys/journey/repository/firebase_journey_repository.dart';
import 'journeys/step/repository/step_firebase_controller.dart';
import 'journeys/step/repository/step_firebase_repository.dart';
import 'journeys/journey_module.dart';
import 'journeys/user_journey/user_journey.dart';
import 'notification/controller/notification_controller.dart';
import 'notification/pages/notification_page.dart';
import 'notification/repository/notification_firebase_repository.dart';
import 'video/page/palestra_list_page.dart';
import 'video/video_controller.dart';

class BaseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AccountController()),
        Bind((i) => BaseController()),
        Bind((i) => CommunityController()),

        Bind((i) => DeleteAccountController()),
        Bind((i) => JourneyListController()),
        Bind((i) => FirebaseJourneyRepository()),
        Bind((i) => FirebaseUserJourneyRepository()),

        Bind((i) => DraftStepFirebaseRepository()),
        Bind((i) => DraftStepFirebaseController()),
        Bind((i) => StepFirebaseController()),
        Bind((i) => StepFirebaseRepository()),
        
        Bind((i) => NotificationController()),
        Bind((i) => NotificationFirebaseRepository()),
        Bind((i) => VideoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/community', module:  CommunityModule()),
        ModuleRoute('/journey', module: JourneyModule()),
        ModuleRoute('/fundamentals', module:  FundamentalsModule()),
        ChildRoute('/video/palestra/list', child: (_,args) => PalestrasListPage()),
        ChildRoute('/', child: (_, args) => BasePage()),

        ChildRoute('/about', child: (_,args) => AboutAppPage()),
        ChildRoute('/alarm', child: (_,args) => Alarm()),
        ChildRoute('/account', child: (_,args) => AccountPage()),
        ChildRoute('/avaliar', child: (_,args) => AvaliaAppPage()),
        ChildRoute('/config', child: (_,args) => ConfigPage()),
        ChildRoute('/delete_account', child: (_,args) => DeleteAccountPage()),
        ChildRoute('/donation', child: (_,args) => DonationPage()),
        ChildRoute('/feature', child: (_,args) => FeaturePage()),
        ChildRoute('/feedback', child: (_,args) => FeedbackPage()),
        ChildRoute('/invite', child: (_,args) => InvitePage()),
        ChildRoute('/notification', child: (_,args) => NotificationPage()),
        ChildRoute('/privacy', child: (_,args) => PrivacyPolicePage()),
        ChildRoute('/settings', child: (_,args) => SettingsPage()),
        ChildRoute('/support', child: (_,args) => SupportPage()),
  ];
}
