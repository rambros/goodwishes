
import 'package:dio/dio.dart';

class SiteListController {
  
  final String _baseUrl = 'https://brahmakumaris.org.br/programacao-teste'; 
  Dio? _dio;
  var result = '';
//   bool busy;


void init() {
      var options = BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: 5000,
    );

    _dio = Dio(options);
}

// Future<String> getSiteEventList() async {
//   var parm = '';
//   _dio.interceptors.add(InterceptorsWrapper(
//          onResponse: _onRespose, onError: _onError));
//   var response = await _dio.get(parm);
//   return response.data as String;
//   }

  dynamic _onRespose(Response resp) {
    print('########### Response Log');
    print(resp.data);
    print('########### Response Log');
    resp.data = extractHtml(resp.data, '<header', '</header>');
    resp.data = extractHtml(resp.data, '<footer', '</footer>');
    return resp.data;
  }

  dynamic _onError(DioError e) {
    return e;
  }

  String extractHtml(String data, String startHtml, String endHtml) {
    var startIndex = data.indexOf(startHtml);
    var endIndex = data.indexOf(endHtml) + endHtml.length;
    var result = data.replaceRange(startIndex, endIndex, '');
    return result;
  }


}