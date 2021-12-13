import 'package:connectivity/connectivity.dart';
import 'package:mobx/mobx.dart';


part 'internet_service.g.dart';

class InternetService = _InternetServiceBase
    with _$InternetService;

abstract class _InternetServiceBase with Store {

  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;


  void InternetService(){
    checkInternet();
  }


  

  void checkInternet() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none) {
      _hasInternet = false;
      
    } else {
      _hasInternet = true;
      
    }
  }


}