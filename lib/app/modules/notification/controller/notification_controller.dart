
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/notification_model.dart';
import '../repository/interface_notification_repository.dart';

part 'notification_controller.g.dart';

class NotificationController = _NotificationControllerBase with _$NotificationController;

abstract class _NotificationControllerBase with Store {
  final _notificationRepository = Modular.get<INotificationRepository>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  } 

   
  DocumentSnapshot? _lastVisible;
  DocumentSnapshot? get lastVisible => _lastVisible;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final _snap = <DocumentSnapshot>[];

  @observable
  List<NotificationModel> _data = [];
  List<NotificationModel> get data => _data;

  @observable
  bool? _hasData;
  bool? get hasData => _hasData;

  void init() {
    //mudança para diminuir leituras 
    getData();
  }

  Future<void> getData() async {
    _hasData = true;
    QuerySnapshot? rawData;
    
    rawData = await (_notificationRepository.getData( _lastVisible )) ;  
     
    if (rawData != null && rawData.docs.isNotEmpty) {
      _lastVisible = rawData.docs[rawData.docs.length - 1];
        _isLoading = false;
        _snap.addAll(rawData.docs);
        _data = _snap.map((e) => NotificationModel.fromFirestore(e as DocumentSnapshot<Map<String, dynamic>>)).toList();
    } else {
      if(_lastVisible == null){
        _isLoading = false;
        _hasData = false;
        print('Não existem notificações');
      } else {
        _isLoading = false;
        _hasData = true;
        print('Não existem mais notificações');
      }
    }
    return null;
  }

  void setLoading(bool isloading) {
    _isLoading = isloading;
  }

  @action
  void onRefresh() {
    _isLoading = true;
    _snap.clear();
    _data.clear();
    _lastVisible = null;
    getData();
  }
}
