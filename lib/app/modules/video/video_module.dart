import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/video/page/canal_viver_search_page.dart';

import 'controller/canal_viver_search_controller.dart';
import 'page/canal_viver_list_page.dart';
import 'page/congresso_list_page.dart';
import 'page/palestra_list_page.dart';
import 'page/entrevista_list_page.dart';
import 'video_controller.dart';
import 'video_page.dart';


class VideoModule extends Module {
  @override
  final List<Bind> binds = [
        // declarados no video_module
        Bind((i) => VideoController()),
        Bind((i) => CanalViverSearchController()),
      ];

  Widget get view => VideoPage(); 

  @override
  final List<ChildRoute> routes = [
        ChildRoute('/', child: (_, args) => VideoPage()),
        ChildRoute('/canalviver/list', child: (_, args) => CanalViverListPage()),
        ChildRoute('/canalviver/search', child: (_, args) => CanalViverSearchPage()),
        ChildRoute('/palestra/list', child: (_, args) => PalestrasListPage()),
        ChildRoute('/entrevista/list', child: (_, args) => EntrevistasListPage()),
        ChildRoute('/congresso/yoga', child: (_, args) => CongressoListPage()),
      ];

  //static Inject get to => Inject<VideoModule>.of();
}

class PalestraListPage {
}
