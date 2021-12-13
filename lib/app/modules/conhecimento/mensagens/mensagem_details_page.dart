import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';
import 'package:share/share.dart';

import 'mensagem.dart';
import 'mensagem_controller.dart';

class MensagemDetailsPage extends StatefulWidget {
  final Mensagem? mensagem;
  const MensagemDetailsPage({Key? key, this.mensagem}) : super(key: key);

  @override
  _MensagemDetailsPageState createState() => _MensagemDetailsPageState();
}

class _MensagemDetailsPageState
    extends ModularState<MensagemDetailsPage, MensagemController> {
  //final format = DateFormat("dd/MM/yyyy");
  late String headerTitle;
  Mensagem? mensagem;

  @override
  void initState() {
    final loadMsgHoje = true;
    if (widget.mensagem == null) {
      controller.init(loadMsgHoje);
      headerTitle = 'Mensagem para Hoje';
    } else {
      controller.init(!loadMsgHoje);
      headerTitle = 'Mensagem positiva';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(headerTitle),
          actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 28.0),
            icon: Icon(Icons.search, size: 32.0 ),
            onPressed: () {
              Modular.to.pushReplacementNamed('/conhecimento/mensagemSearch');
            },
          ),
        ],
        ),
        body: Observer(
          builder: (BuildContext context) {
            return controller.isLoading
                ? Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  )
                : ShowMensagemDetails(
                      controller: controller, 
                      mensagem: (widget.mensagem == null) ? controller.mensagemHoje : widget.mensagem
                  );
          },
        ));
  }
}

class ShowMensagemDetails extends StatelessWidget {
  const ShowMensagemDetails({
    Key? key,
    required this.controller,
    this.mensagem,
  }) : super(key: key);

  final MensagemController controller;
  final Mensagem? mensagem;

  @override
  Widget build(BuildContext context) {
    //var mensagem = controller.getMensagemHoje();
    var msgToShare =
        '''  *Mensagem positiva para hoje*\n\n*${mensagem!.tema}*\n${mensagem!.mensagem}\n\nhttps://www.brahmakumaris.org.br/downloads/meditabk''';
    //' ${GlobalConfiguration().getString("dynamicLinkInvite")}''';
    return SingleChildScrollView(
        child: Stack(children: <Widget>[
      Positioned(
        top: -10,
        //height: MediaQuery.of(context).size.height,
        height: 800,
        width: MediaQuery.of(context).size.width,
        child: FadeAnimation(
          6,
          AnimatedOpacity(
            opacity: 0.7,
            duration: Duration(seconds: 12),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.linearToSrgbGamma(),
                      image: AssetImage('assets/images/shiva-point.jpg'),
                      fit: BoxFit.fill)),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpace(48),
            Center(
              child: Text(mensagem!.tema!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            ),
            verticalSpace(24),
            Center(
              child: Text(
                mensagem!.mensagem!,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            verticalSpace(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                    primary: Theme.of(context).colorScheme.primary,
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    //textColor: Colors.white,
                  elevation: 2,
                  ),
                  onPressed: () {
                    final box = context.findRenderObject() as RenderBox;
                    Share.share(msgToShare,
                        subject: 'App MeditaBK',
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                  child: Text('Compartilhar esta Mensagem'.toUpperCase()),
                ),
              ],
            ),
            verticalSpace(500),
          ],
        ),
      ),
    ]));
  }
}

