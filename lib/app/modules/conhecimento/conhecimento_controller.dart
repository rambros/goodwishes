import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

import '../../modules/home_option_model.dart';
import './mensagens/mensagem.dart';
part 'conhecimento_controller.g.dart';

class ConhecimentoController = _ConhecimentoController with _$ConhecimentoController;

abstract class _ConhecimentoController with Store {

  final List<HomeOption> _listConhecimentoOptions = [
     HomeOption(
       text: 'Mensagem para o dia',
       urlDestino: '/conhecimento/mensagemDetails', 
       colorStart: Colors.orange[200],
       colorEnd: Colors.orange[400],
       icon: Icons.filter_vintage,),
    HomeOption(
       text: 'Pesquisar mensagens',
       urlDestino: '/conhecimento/mensagemSearch', 
       colorStart: Colors.red[200],
       colorEnd: Colors.red[400],
       icon: Icons.search,),
  ];

  List<HomeOption> get listConhecimentoOptions => _listConhecimentoOptions;

  @observable
  int? _currentIndex;

  @action
  void changeIndex(int value) => _currentIndex = value;

  @computed
  int get currentIndex => _currentIndex?? 0;

  List<Mensagem>? _mensagensList = [];
  List? get mensagensList => _mensagensList;

   void init() async {
     //Hive.openBox<Mensagem>('mensagens');
     await getData();  
     }

  Future<String> loadString(String key) async {
    final  data = await rootBundle.load(key);
    return utf8.decode(data.buffer.asUint8List());
  }

  Future getData() async {
    var data = await loadString('assets/json/mensagens.json');
    var listJsonMensagens = parseJson(data.toString());  
    _mensagensList = listJsonMensagens;
    _mensagensList!.sort((a, b) => a.tema!.compareTo(b.tema!));
  }

   List<Mensagem>? parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Mensagem>((json) => Mensagem.fromJson(json)).toList();
  }


  }
