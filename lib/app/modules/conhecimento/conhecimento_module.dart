import 'package:flutter_modular/flutter_modular.dart';

import 'mensagens/mensagem_controller.dart';
import 'mensagens/mensagem_details_page.dart';
import 'mensagens/mensagem_search_controller.dart';
import 'mensagens/mensagem_search_page.dart';

class ConhecimentoModule extends Module {
  @override
  final List<Bind> binds = [
        Bind((i) => MensagemController()),
        Bind((i) => MensagemSearchController()),
      ];

  @override
  final List<ModularRoute> routes = [
        ChildRoute('/mensagemSearch', child: (_,args) => MensagemSearchPage()),
        ChildRoute('/mensagemDetails', child: (_,args) => MensagemDetailsPage(mensagem: args.data)),
  ];

  //static Inject get to => Inject<ConhecimentoModule>.of();
  
}
