import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/base_controller.dart';

import '../shared/author/controller/author_add_controller.dart';
import '../shared/author/controller/author_edit_controller.dart';
import '../shared/author/controller/author_list_controller.dart';
import '../shared/author/page/author_add_page.dart';
import '../shared/author/page/author_details_page.dart';
import '../shared/author/page/author_edit_page.dart';
import '../shared/author/page/author_list_page.dart';
import '../shared/author/page/author_select_page.dart';
import '../shared/reminder/alarm.dart';
import '../shared/settings/settings_page.dart';

import 'autentica/page/privacy_police_page.dart';
import 'base_page.dart';
import 'category/category_add_controller.dart';
import 'category/category_add_page.dart';
import 'category/category_controller.dart';
import 'category/category_list_controller.dart';
import 'category/category_list_page.dart';
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
import 'conhecimento/conhecimento_controller.dart';
import 'conhecimento/conhecimento_module.dart';
import 'meditation/draft_step/repository/draft_step_firebase_controller.dart';
import 'meditation/draft_step/repository/draft_step_firebase_repository.dart';
import 'meditation/guided/controller/med_list_controller.dart';
import 'meditation/guided/repository/med_firebase_controller.dart';
import 'meditation/guided/repository/med_firebase_repository.dart';
import 'meditation/meditation_controller.dart';
import 'meditation/meditation_module.dart';
import 'notification/controller/notification_controller.dart';
import 'notification/pages/notification_page.dart';
import 'notification/repository/notification_firebase_repository.dart';
import 'video/page/canal_viver_list_page.dart';
import 'video/video_controller.dart';
import 'video/video_module.dart';

class BaseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AccountController()),
        //Bind((i) => AudioPlayerController()),
        Bind((i) => AuthorAddController()),
        Bind((i) => AuthorEditController()),
        Bind((i) => AuthorListController()),
        Bind((i) => BaseController()),
        Bind((i) => CategoryController()),
        Bind((i) => CategoryAddController()),
        Bind((i) => CategoryListController()),
        Bind((i) => ConhecimentoController()),
        Bind((i) => DeleteAccountController()),
        Bind((i) => DraftStepFirebaseController()),
        Bind((i) => DraftStepFirebaseRepository()),
        Bind((i) => MeditationController()),
        Bind((i) => MeditationListController()),
        Bind((i) => MeditationFirebaseController()),
        Bind((i) => MeditationFirebaseRepository()),
        Bind((i) => NotificationController()),
        Bind((i) => NotificationFirebaseRepository()),
        Bind((i) => VideoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => BasePage()),
        ModuleRoute('/conhecimento', module:  ConhecimentoModule()),
        ModuleRoute('/meditation', module: MeditationModule()),
        ModuleRoute('/video', module:  VideoModule()),

        ChildRoute('/author/list', child: (_,args) => AuthorListPage()),
        ChildRoute('/author/add', child: (_,args) => AuthorAddPage()),
        ChildRoute('/author/select', child: (_,args) => AuthorSelectPage()),
        ChildRoute('/author/details', child: (_,args) => AuthorDetailsPage(author: args.data)),
        ChildRoute('/author/edit', child: (_,args) => AuthorEditPage(author: args.data)),
        ChildRoute('/about', child: (_,args) => AboutAppPage()),
        ChildRoute('/alarm', child: (_,args) => Alarm()),
        ChildRoute('/account', child: (_,args) => AccountPage()),
        ChildRoute('/avaliar', child: (_,args) => AvaliaAppPage()),
        ChildRoute('/category/add', child: (_,args) => CategoryAddPage()),
        ChildRoute('/category/list', child: (_,args) => CategoryListPage()),
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

  //static Inject get to => Inject<BaseModule>.of();
}
