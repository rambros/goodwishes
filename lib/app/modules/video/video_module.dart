import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'page/palestra_list_page.dart';
import 'video_controller.dart';
import 'video_page.dart';


class VideoModule extends Module {
  @override
  final List<Bind> binds = [
        // declarados no video_module
        Bind((i) => VideoController()),
      ];

  Widget get view => VideoPage(); 

  @override
  final List<ChildRoute> routes = [
        ChildRoute('/', child: (_, args) => VideoPage()),
        ChildRoute('/palestra/list', child: (_, args) => PalestrasListPage()),
      ];

  //static Inject get to => Inject<VideoModule>.of();
}

class PalestraListPage {
}
