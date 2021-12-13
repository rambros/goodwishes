import 'package:audio_service/audio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'modules/base_module.dart';
import 'modules/autentica/autentica_module.dart';
import 'modules/category/category_repository.dart';
import 'shared/author/controller/author_controller.dart';
import 'shared/services/cloud_storage_service.dart';
import 'shared/services/dialog_service.dart';
import 'shared/services/local_storage_service.dart';
import 'shared/services/authentication_service.dart';
import 'shared/services/notification_service.dart';
import 'shared/services/user_service.dart';
import 'shared/services/analytics_service.dart';
import 'shared/settings/settings_controller.dart';
import 'shared/splash/splash_controller.dart';
import 'shared/splash/splash_page.dart';
import 'shared/utils/image_selector.dart';
import 'shared/user/user_firebase_repository.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => SplashController()),

        // Global services
        Bind((i) => DialogService()),
        Bind((i) => CloudStorageService()),
        Bind((i) => LocalStorageService()),
        Bind((i) => UserService()),
        Bind((i) => AuthenticationService()),
        Bind((i) => AnalyticsService()),
        Bind((i) => NotificationService()),

        Bind((i) => ImageSelector()),
        Bind((i) => AuthorController()),
        Bind((i) => SettingsController()),
        Bind((i) => CategoryRepository()),

        //repositories 
        Bind((i) => UserFirebaseRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/splash', child: (_, __) => SplashPage()),
        ModuleRoute('/login', module: AutenticaModule()),
        ModuleRoute('/', module:  BaseModule()),
      ];

  // @override
  // Widget get bootstrap => AppWidget();
}