import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';

import '../controller/timer_controller.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends ModularState<TimerPage, TimerController> {
  var musicSelectedTitle;
  var soundStartSelectedTitle;
  var soundEndSelectedTitle;

  void _updateTitle(){
      setState(() {
           musicSelectedTitle = controller.getTitle();
           soundStartSelectedTitle = controller.getTitleStartSound();
           soundEndSelectedTitle = controller.getTitleEndSound();
       });
  }

  @override
  Widget build(BuildContext context) {
    //_updateTitle();
    return Scaffold(
        appBar: AppBar(
          title: Text('Meditar com timer'),
        ),
        //backgroundColor: Colors.white, //Theme.of(context).accentColor,
        body: SingleChildScrollView(
          child: FadeAnimation(
            0.5,
            Observer(
              builder: (BuildContext context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    verticalSpace(24),
                    Center(
                      child: Text('Timer para Meditação',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    ),
                    verticalSpace(16),
                    configTimer(
                      context: context,
                      title: 'Duração',
                      value: '${controller.minutos}min ${controller.segundos}seg',
                      iconData: Icons.timer,
                      todo: 'duration',
                    ),
                    verticalSpace(8),
                    configTimer(
                      context: context,
                      title: 'Som para iniciar',
                      value: soundStartSelectedTitle?? 'Nenhum som selecionado',
                      iconData: Icons.music_note,
                      todo: 'selection start music',
                    ),
                    verticalSpace(8),
                    configTimer(
                      context: context,
                      title: 'Música de fundo',
                      value: musicSelectedTitle?? 'Nenhuma selecionada',
                      iconData: Icons.music_video,
                      todo: 'selection music',
                    ),
                    verticalSpace(8),
                    configTimer(
                      context: context,
                      title: 'Som para finalizar',
                      value: soundEndSelectedTitle?? 'Nenhum som selecionado',
                      iconData: Icons.music_note,
                      todo: 'selection end music',
                    ),
                    verticalSpace(16),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 6.0, top: 6.0),
                      elevation: 2,
                      child: Text(
                        'Iniciar',
                        style: TextStyle(
                            color: Colors.white,
                          ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        var timerModel = controller.getTimerModel;
                        Modular.to.pushNamed('/meditation/timer_player', arguments: timerModel);
                      },
                    ),
                    // IconButton(
                    //     iconSize: 96,
                    //     alignment: Alignment.topCenter,
                    //     color: Theme.of(context).accentColor,
                    //     icon: Icon(
                    //       Icons.play_circle_outline,
                    //     ),
                    //     onPressed: () {
                    //       var timerModel = controller.getTimerModel;
                    //       Modular.to.pushNamed('/meditation/timer_player', arguments: timerModel);
                    //     }),
                    verticalSpace(16),
                  ],
                );
              },
            ),
          ),
        ));
  }

   void _showPickerNumberFormatValue(BuildContext context) {
    Picker(
       footer: Text('Minutos      Segundos',
                  style: TextStyle(
                        fontSize: 20, 
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
        ),
        cancelText: 'Cancelar',
        cancelTextStyle: TextStyle(
                          fontSize: 18, 
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700),
        confirmText: 'Confirmar',
        confirmTextStyle: TextStyle(
                          fontSize: 18, 
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700),
        magnification: 1.5,
        itemExtent: 38,
        height: 200,
        columnPadding: EdgeInsets.all(1),
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              begin: 0,
              end: 99,
              initValue: controller.minutos
              // onFormatValue: (v) {
              //   return v < 10 ? "0$v" : "$v";
              // }
          ),
          NumberPickerColumn(begin: 0, end: 59, initValue: controller.segundos),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Text(':', style: TextStyle(fontSize: 24),),
          ))
        ],
        hideHeader: true,
        title: Center(child: Text('Duração do timer', 
                    style: TextStyle(
                        fontSize: 24, 
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                ),),
        selectedTextStyle: TextStyle(color: Theme.of(context).accentColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          controller.minutos = value[0];
          controller.segundos = value[1];
        }
    ).showDialog(context);
  }


  GestureDetector configTimer (
      {required BuildContext context, required String title, required String value, IconData? iconData, String? todo}) {
  return GestureDetector (
      onTap: () {
        switch (todo) {
          case 'duration':
            _showPickerNumberFormatValue(context);
            break;
          case 'selection music':
            Modular.to.pushNamed('/meditation/timer/music/selection').then((value){
              _updateTitle();
            });
            break;
          case 'selection start music':
            Modular.to.pushNamed('/meditation/timer/start_sound/selection').then((value){
              _updateTitle();
            });
            break;
          case 'selection end music':
            Modular.to.pushNamed('/meditation/timer/end_sound/selection').then((value){
              _updateTitle();
            });
            break;
          default:
        }
        ;
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 6.0, top: 6.0),
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Theme.of(context).accentColor, width: 2.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(6),
          // boxShadow: _appSettings.isDarkTheme
          //     ? [
          //         BoxShadow(
          //             blurRadius: 8, color: Colors.grey[850], spreadRadius: 3)
          //       ]
          //     : [
          //         BoxShadow(
          //             blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          //       ],
        ),
        alignment: Alignment.center,
        child: Material(
          borderRadius: BorderRadius.circular(6.0),
          elevation: 0,
          child: Container(
            height: 100.0,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        iconData,
                        size: 48,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 2.0, top: 6.0),
                      child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                        ),
                        verticalSpace(4),
                        Text(
                          value,
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.0),
                        ),
                      ]),
                    ),
                  ],
                )),
                Icon(
                  Icons.play_arrow,
                  size: 48,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _showInputDurationDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: Text('Duração da meditação',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
  //         content: Observer(
  //           builder: (BuildContext context) {
  //             return Padding(
  //               padding: const EdgeInsets.only(top: 8),
  //               child: Container(
  //                 height: 200,
  //                 //width: 500,
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: <Widget>[
  //                         // Column(
  //                         //   children: <Widget>[
  //                         //     Text('HH'),
  //                         //     NumberPicker.integer(
  //                         //       decoration: _decoration,
  //                         //       initialValue: 0,
  //                         //       minValue: 0,
  //                         //       maxValue: 23,
  //                         //       listViewWidth: 20,
  //                         //       infiniteLoop: true,
  //                         //       //zeroPad: true,
  //                         //       highlightSelectedValue: true,
  //                         //       onChanged: (valor) {
  //                         //         print(valor);
  //                         //         setState(
  //                         //             () => controller.horas = valor?? 0);
  //                         //       },
  //                         //     ),
  //                         //   ],
  //                         // ),
  //                         Column(
  //                           children: <Widget>[
  //                             Text('Minutos'),
  //                             NumberPicker.integer(
  //                               //decoration: _decoration,
  //                               initialValue: 0,
  //                               minValue: 0,
  //                               maxValue: 90,
  //                               listViewWidth: 40,
  //                               infiniteLoop: true,
  //                               zeroPad: true,
  //                               highlightSelectedValue: true,
  //                               onChanged: (valor) {
  //                                 print(valor);
  //                                 setState(() => controller.minutos = valor);
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                         Column(
  //                           children: <Widget>[
  //                             Text('Segundos'),
  //                             NumberPicker.integer(
  //                               //decoration: _decoration,
  //                               initialValue: controller.segundos,
  //                               minValue: 0,
  //                               maxValue: 59,
  //                               //listViewWidth: 40,
  //                               infiniteLoop: true,
  //                               zeroPad: true,
  //                               highlightSelectedValue: true,
  //                               onChanged: (valor) {
  //                                 print(valor);
  //                                 setState(() => controller.segundos = valor);
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     verticalSpace(4),
  //                     Text('Duração: ${controller.minutos}min ${controller.segundos}seg'),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           FlatButton(
  //             child: Text('Cancelar',
  //                 style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w700,
  //                     color: Theme.of(context).accentColor)),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           FlatButton(
  //             child: Text('Salvar',
  //                 style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w700,
  //                     color: Theme.of(context).accentColor)),
  //             onPressed: () {
  //               //if (_valor != 0) {
  //               //salvar o campo
  //               //controller.duration = _valor.toString();
  //               //print(comment.text);
  //               Navigator.of(context).pop();
  //               //}
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   // flutter defined function
  // }

//   final Decoration _decoration = BoxDecoration(
//     border: Border(
//       top: BorderSide(
//         style: BorderStyle.solid,
//         color: Colors.black26,
//       ),
//       bottom: BorderSide(
//         style: BorderStyle.solid,
//         color: Colors.black26,
//       ),
//     ),
//   );

}
