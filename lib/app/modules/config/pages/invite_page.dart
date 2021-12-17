import 'dart:math';
import 'package:global_configuration/global_configuration.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = Size(MediaQuery.of(context).size.width, 200.0);
    return Scaffold(
        appBar: AppBar(
          title: Text('Invite your friends'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Container(
                width: size.width,
                height: MediaQuery.of(context).size.height * .12,
                // child: Image.network(
                //   'https://www.tokia.io/wp-content/uploads/2018/10/tokia-refferal-illiustration-2.png',
                //   fit: BoxFit.cover,
                //),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Invite your friends',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Invite your friends to experience GoodWishes app',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  shadowColor: Colors.red,
                  //color: Theme.of(context).colorScheme.secondary,
                  //textColor: Colors.white,
                  elevation: 2,
                ),
                onPressed: () {
                  final box = context.findRenderObject() as RenderBox;
                  Share.share('''Olá, estou usando esse Aplicativo de MEDITAÇÃO.\n
Ele nos ajuda na jornada do autoconhecimento e conexão com o Eu interior, por isso quero recomendar a você.\n
Baixe no link a seguir o  App MEDITABK da Brahma Kumaris, é 100% gratuito. ${GlobalConfiguration().getString("dynamicLinkInvite")}''',
                      subject: 'App MeditaBK',
                      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                },
                child: Text('Invite your friends'.toUpperCase()),
              ),
              Expanded(child: Container()),
              ShareInvite(
                size: size,
                xOffset: 50,
                color: Theme.of(context).colorScheme.secondary,
                yOffset: 10,
              )
            ],
          ),
        ));
  }
}

class ShareInvite extends StatefulWidget {
  final Size? size;
  final int? xOffset;
  final int? yOffset;
  final Color? color;
  ShareInvite({this.size, this.xOffset, this.yOffset, this.color});

  @override
  _ShareInviteState createState() => _ShareInviteState();
}

class _ShareInviteState extends State<ShareInvite> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (var i = -2 - widget.xOffset!; i <= widget.size!.width.toInt() + 2; i++) {
        animList1.add(Offset(
            i.toDouble() + widget.xOffset!,
            sin((animationController.value * 360 - i) % 360 * vector.degrees2Radians) * 20 +
                50 +
                widget.yOffset!));
      }
    });
    animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => ClipPath(
          clipper: WaveClipper(animationController.value, animList1),
          child: widget.color == null
              ? Image.asset(
                  'images/demo5bg.jpg',
                  width: widget.size!.width,
                  height: widget.size!.height,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: widget.size!.width,
                  height: widget.size!.height,
                  color: widget.color,
                ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    var path = Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => animation != oldClipper.animation;
}
