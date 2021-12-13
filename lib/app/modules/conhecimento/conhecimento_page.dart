import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/home_widgets.dart';
import '/app/shared/widgets/page_bar_widget.dart';
import 'conhecimento_controller.dart';

class ConhecimentoPage extends StatefulWidget {
  const ConhecimentoPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConhecimentoPageState createState() => _ConhecimentoPageState();
}

class _ConhecimentoPageState
    extends ModularState<ConhecimentoPage, ConhecimentoController> {
  //final _appSettings = Modular.get<AppController>();

  double paddingValue = 20;

  @override
  void initState() {
    controller.init();
    Future.delayed(Duration(milliseconds: 5)).then((f) {
      setState(() {
        paddingValue = 0;
      });
    });
    //Hive.openBox('Mensagems');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeOptions = controller.listConhecimentoOptions;
    return Scaffold(
      appBar: PageBar(title: 'Mensagens'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(32),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Reflexões para o seu dia',
                style: TextStyle(fontSize: 22, 
                              fontWeight: FontWeight.w600,
                              //color: Colors.black54,
                              ),
              ),
            ),
          ),
          verticalSpace(16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              children: List.generate(homeOptions.length, (index) {
                return InkWell(
                  onTap: () {
                    Modular.to.pushNamed(homeOptions[index].urlDestino!);
                  },
                  child: Hero(
                    tag: 'category$index',
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          //color: homeOptions[index].colorStart,
                          gradient: LinearGradient(
                              begin: Alignment(0.0 ,0.0 ),
                              end: Alignment(1.0 , 1.0 ),
                              colors: [homeOptions[index].colorStart!, homeOptions[index].colorEnd!]),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey[700]!,
                                blurRadius: 2,
                                offset: Offset(2, 2))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AnimatedPadding(
                            duration: Duration(milliseconds: 600),
                            padding: EdgeInsets.all(paddingValue),
                            child: Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.white10,
                                          blurRadius: 30,
                                          offset: Offset(3, 3))
                                    ]),
                                child: Icon(
                                  homeOptions[index].icon,
                                  size: 30,
                                  color: Colors.black54,
                                )),
                          ),
                          Spacer(),
                          Text(
                            homeOptions[index].text!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
