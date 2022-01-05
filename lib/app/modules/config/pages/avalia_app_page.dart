import 'dart:math';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class AvaliaAppPage extends StatelessWidget {

  final InAppReview _inAppReview = InAppReview.instance;
  final String _appStoreId = '1524154748';

  //void _setAppStoreId(String id) => _appStoreId = id;

  Future<void> _requestReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    }
  }

  Future<void> _openStoreListing() =>
      _inAppReview.openStoreListing(appStoreId: _appStoreId);

  @override
  Widget build(BuildContext context) {
    var size = Size(MediaQuery.of(context).size.width, 200.0);
    return Scaffold(
        appBar: AppBar(
          title: Text('Avalie o app GoodWishes'),
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
                child: Image.asset('assets/images/logo_goodwishes.png',
                      width: 220, height: 220),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Avalie o app GoodWishes',
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
                  'Está gostando do GoodWishes?\nTem sugestões para melhorias?\nAjude-nos a melhorar o app MeditaBK. Deixe sua avaliação e comentários na loja de apps.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  primary: Theme.of(context).colorScheme.secondary,// background
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: () {
                  _requestReview();
                }, 
                child: Text('Avaliação aqui mesmo'.toUpperCase()),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  primary: Theme.of(context).colorScheme.secondary,// background
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: () {
                  _openStoreListing();
                }, 
                child: Text('Faça uma avaliação na loja'.toUpperCase()),
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

class _ShareInviteState extends State<ShareInvite>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (var i = -2 - widget.xOffset!;
          i <= widget.size!.width.toInt() + 2;
          i++) {
        animList1.add(Offset(
            i.toDouble() + widget.xOffset!,
            sin((animationController.value * 360 - i) %
                        360 *
                        vector.degrees2Radians) *
                    20 +
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
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
