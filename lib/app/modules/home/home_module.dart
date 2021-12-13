import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> binds = [
  ];

  @override
  final List<ChildRoute> routes = [
        //Router('/', child: (_, args) => BasePage()),
        //Router('/home', module:  HomeModule()),
      ];

  //static Inject get to => Inject<HomeModule>.of();
}
