import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '/app/shared/utils/ui_utils.dart';

import 'mensagem_search_controller.dart';

class MensagemSearchPage extends StatefulWidget {
  const MensagemSearchPage({Key? key}) : super(key: key);

  @override
  _MensagemSearchPageState createState() => _MensagemSearchPageState();
}

class _MensagemSearchPageState
    extends ModularState<MensagemSearchPage, MensagemSearchController> {
  var formKey = GlobalKey<FormState>();
  var textFieldCtrl = TextEditingController();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Form(
            key: formKey,
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Digite o termo para pesquisar',
                focusColor: Colors.white,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    WidgetsBinding.instance!
                        .addPostFrameCallback((_) => textFieldCtrl.clear());
                    controller.afterMensagemSearch('');
                  },
                ),
              ),
              controller: textFieldCtrl,
              onChanged: (String value) {
                controller.afterMensagemSearch(value);
              },
            ),
          )),
      body: Observer(
        builder: (BuildContext context) {
          return  
            controller.mensagensFiltered.isEmpty
              ? suggestionUI(context)
              : afterMensagemsearchUI(context);
        },
      ),

      //   body:
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Observer(
      //       builder: (BuildContext context) {
      //         return Column(
      //           mainAxisSize: MainAxisSize.max,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: <Widget>[
      //             verticalSpace(15),
      //             controller.mensagensFiltered.isNotEmpty
      //                 ? Text(
      //                     'Resultado da Pesquisa - ${controller.mensagensFiltered.length} mensagens')
      //                 : Text('Digite o texto para pesquisar'),
      //             verticalSpace(10),
      //             Material(
      //               child: controller.mensagensFiltered.isEmpty
      //                   ? suggestionUI(context)
      //                   : afterMensagemsearchUI(context),
      //             ),
      //           ],
      //         );
      //       },
      //     ),
      //   ),
      // ),







    );
  }

  Widget suggestionUI(context) {
    return controller.isLoading
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).accentColor),
              ),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.all(15),
            itemCount: controller.mensagensList!.take(150).length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 300),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: InkWell(
                      child: Container(
                        height: 115,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 10,
                                offset: Offset(0, 3))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              controller.mensagensList![index].tema,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpace(8),
                            Container(
                              child: Text(
                                controller.mensagensList![index].mensagem,
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Text(
                            //   controller.MensagensList[index]['loves'].toString(),
                            //   style:
                            //       TextStyle(color: Colors.black38, fontSize: 13),
                            // ),
                          ],
                        ),
                      ),
                      onTap: () {
                        controller.showDetails(controller.mensagensList![index]);
                      },
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget afterMensagemsearchUI(context) {
    return ListView.separated(
      padding: EdgeInsets.all(15),
      itemCount: controller.mensagensFiltered.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: Duration(milliseconds: 300),
          child: SlideAnimation(
            verticalOffset: 50,
            child: FadeInAnimation(
              child: GestureDetector(
                child: Container(
                  height: 110,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[100]!,
                          blurRadius: 10,
                          offset: Offset(0, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller.mensagensFiltered[index].tema,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(8),
                      Container(
                        child: Text(
                          controller.mensagensFiltered[index].mensagem,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Text(
                      //   controller.MensagensList[index]['loves'].toString(),
                      //   style:
                      //       TextStyle(color: Colors.black38, fontSize: 13),
                      // ),
                    ],
                  ),
                ),
                onTap: () {
                  controller.showDetails(controller.mensagensFiltered[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
