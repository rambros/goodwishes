import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../conhecimento_controller.dart';
import 'mensagem.dart';
part 'mensagem_search_controller.g.dart';


class MensagemSearchController = _MensagemSearchControllerBase with _$MensagemSearchController;

abstract class _MensagemSearchControllerBase with Store {

  final _conhecimentoController = Modular.get<ConhecimentoController>();

  void init() async {
    //await Hive.openBox<Mensagem>('mensagens');
    await getData();
  }

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @action
  void setIsLoading(bool value) {
    _isLoading = value;
  }

  @observable
  List<Mensagem>? _mensagensList = [];

  @observable
  List<Mensagem> _mensagensFiltered = [];

  bool _hasData = false;

  List? get mensagensList => _mensagensList;
  List get mensagensFiltered => _mensagensFiltered;
  bool get hasData => _hasData;

  Future getData() async {
    setIsLoading(true); 
    if (_conhecimentoController.mensagensList!.isEmpty) {
      await _conhecimentoController.getData();
    }
    _mensagensList = _conhecimentoController.mensagensList as List<Mensagem>?;
    setIsLoading(false);
  }

  void afterMensagemSearch(value) {
    _mensagensFiltered = _mensagensList!
        .where((u) => (u.tema!.toLowerCase().contains(value.toLowerCase())) 
        ||  u.mensagem!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    _mensagensFiltered.isEmpty ? _hasData = false : _hasData = true;
  }

  void showDetails(Mensagem mensagem) {
    Modular.to.pushNamed('/conhecimento/mensagemDetails',arguments: mensagem);
  }

  void shareMensagem(Mensagem Mensagem) {
    // final RenderBox box = context.findRenderObject();
    //                     Share.share(
    //                         'MeditaBK - Brahma Kumaris Brasil - Mensagem Positivo para hoje - ${widget.Mensagem.tema} - ${widget.Mensagem.texto}',
    //                         //' ${GlobalConfiguration().getString("dynamicLinkInvite")}',
    //                         subject: 'App MeditaBK',
    //                         sharePositionOrigin:
    //                             box.localToGlobal(Offset.zero) & box.size);

  }

}