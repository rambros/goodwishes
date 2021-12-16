import 'package:flutter_modular/flutter_modular.dart';

import 'community_controller.dart';
import 'community_page.dart';


class CommunityModule extends Module {
  @override
  final List<Bind> binds = [
        Bind((i) => CommunityController()),
      ];

  @override
  final List<ModularRoute> routes = [
        ChildRoute('/', child: (_,args) => CommunityPage()),
  ];

}
