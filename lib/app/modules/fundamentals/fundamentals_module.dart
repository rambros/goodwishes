import 'package:flutter_modular/flutter_modular.dart';

import 'fundamentals_page.dart';


class FundamentalsModule extends Module {
  @override
  final List<Bind> binds = [
      ];

  @override
  final List<ModularRoute> routes = [
        ChildRoute('/', child: (_,args) => FundamentalsPage()),
  ];

}
