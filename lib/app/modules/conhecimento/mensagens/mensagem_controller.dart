
import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/services/local_storage_service.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

import '../conhecimento_controller.dart';
import 'mensagem.dart';
part 'mensagem_controller.g.dart';


class MensagemController = _MensagemControllerBase with _$MensagemController;

abstract class _MensagemControllerBase with Store {
  final _localStorage = Modular.get<LocalStorageService>();
  final _conhecimentoController = Modular.get<ConhecimentoController>();

  void init(bool loadMsgHoje) async {
    await getData(loadMsgHoje);
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
  List<String> listaIndicesMensagensDia = [];
  Mensagem? _mensagemHoje;

  bool _hasData = false;

  List? get mensagensList => _mensagensList;
  bool get hasData => _hasData;
  Mensagem? get mensagemHoje => _mensagemHoje;
  String? _dataHojeSalva;

  Future getData(bool loadMsgHoje) async {
    setIsLoading(true); 
    if (_conhecimentoController.mensagensList!.isEmpty) {
      await _conhecimentoController.getData();
    }
    _mensagensList = _conhecimentoController.mensagensList as List<Mensagem>?;

    if (loadMsgHoje) {
    // lista dos indices das mensagens do dia para este usuário
    if ( listaIndicesMensagensDia.isEmpty) {
      listaIndicesMensagensDia = await _localStorage.getListaIndicesMensagensDia();
    }
    _dataHojeSalva = await _localStorage.getDataHojeSalva();
    _mensagemHoje = await getMensagemHoje();
    }
    setIsLoading(false);
  }

  

  Future<Mensagem> getMensagemHoje() async {
    // verifica se ainda está no dia da execução...
    final dataHoje = getDataHoje();
    if (_dataHojeSalva == dataHoje) {
      final _indexMsgHoje = await _localStorage.getIndexMensagemHoje();
      return _mensagensList![_indexMsgHoje];
    }
    // precisa gerar nova mensagem e salvar como mensagem de hoje
    var index = getRandom();
    //verifica se mensagem já não foi utilizada
    while (listaIndicesMensagensDia.contains(index.toString())) {
      index = getRandom();
    }
    listaIndicesMensagensDia.add(index.toString());
     _localStorage.setDataHojeSalva(dataHoje);
     _localStorage.setIndexMensagemHoje(index);
     _localStorage.setListaIndicesMensagensDia(listaIndicesMensagensDia);
    return _mensagensList![index];
  }

  String getDataHoje() {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      final formattedDate = formatter.format(now);
      return formattedDate;
  }

  int getRandom() {
    var rnd = Random();
    return rnd.nextInt(_mensagensList!.length);
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