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
import 'journey/draft_step/repository/draft_step_firebase_controller.dart';
import 'journey/draft_step/repository/draft_step_firebase_repository.dart';
import 'journey/step/controller/step_list_controller.dart';
import 'journey/step/repository/step_firebase_controller.dart';
import 'journey/step/repository/step_firebase_repository.dart';
import 'journey/journey_controller.dart';
import 'journey/journey_module.dart';
import 'notification/controller/notification_controller.dart';
import 'notification/pages/notification_page.dart';
import 'notification/repository/notification_firebase_repository.dart';
import 'video/page/canal_viver_list_page.dart';
import 'video/page/palestra_list_page.dart';
import 'video/video_controller.dart';

class BaseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AccountController()),
        Bind((i) => BaseController()),
        Bind((i) => CommunityController()),
        Bind((i) => DeleteAccountController()),
        Bind((i) => DraftStepFirebaseController()),
        Bind((i) => DraftStepFirebaseRepository()),
        Bind((i) => JourneyController()),
        Bind((i) => StepListController()),
        Bind((i) => StepFirebaseController()),
        Bind((i) => StepFirebaseRepository()),
        Bind((i) => NotificationController()),
        Bind((i) => NotificationFirebaseRepository()),
        Bind((i) => VideoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => BasePage()),
        ModuleRoute('/community', module:  CommunityModule()),
        ChildRoute('/video/palestra/list', child: (_,args) => PalestrasListPage()),
        ModuleRoute('/journey', module: JourneyModule()),
        ModuleRoute('/fundamentals', module:  FundamentalsModule()),

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
        ChildRoute('/video/canalviver', child: (_,args) => CanalViverListPage()),
        ChildRoute('/settings', child: (_,args) => SettingsPage()),
        ChildRoute('/support', child: (_,args) => SupportPage()),
  ];
}
