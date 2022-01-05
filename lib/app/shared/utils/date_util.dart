// ignore_for_file: omit_local_variable_types

import 'package:intl/intl.dart';

class DateUtil{

  var mouths =['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];

  String buildDate(String date){
    try{
      var datatime = DateTime.parse(date);
      //return "${datatime.day} de ${mouths[datatime.month-1]} de ${datatime.year} às ${datatime.hour}:${datatime.minute}";
      return '${datatime.day} de ${mouths[datatime.month-1]} de ${datatime.year}';
    }catch(e){
      return '';
    }
  }

  static String converteDMYtoYMD(String date) {
      DateTime dataDMY = DateFormat('dd/MM/yyyy').parse(date);
      String dataYMD = DateFormat('yyyy-MM-dd').format(dataDMY).toString();
      return dataYMD;
  }

  static String converteYMDtoDMY(String date) {
      DateTime dataYMD = DateFormat('yyyy-MM-dd').parse(date);
      String dataDMY = DateFormat('dd/MM/yyyy').format(dataYMD).toString();
      return dataDMY;
  }

}