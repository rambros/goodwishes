import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/home/home_option_model.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/page_bar_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  double paddingValue = 20;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 5)).then((f) {
      setState(() {
        paddingValue = 0;
      });
    });
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeOptions = controller.listHomeOptions;
    return Scaffold(
      appBar: PageBar(title: 'Início'), //HomeAppBar(context: context, title: 'Início'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          verticalSpace(32),
          Center(
            child: Text(
              'O que você quer fazer agora?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                //color: Colors.black54,
              ),
            ),
          ),
          verticalSpace(16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              children: List.generate(homeOptions.length, (index) {
                return InkWell(
                  child: Hero(
                    tag: 'category$index',
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          //color: homeOptions[index].colorStart,
                          gradient: buildLinearGradient(homeOptions, index),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.grey[700]!, blurRadius: 2, offset: Offset(2, 2))
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
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Modular.to.pushNamed(homeOptions[index].urlDestino!);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient buildLinearGradient(List<HomeOption> homeOptions, int index) {

    switch (index) {
      case 0:
        return LinearGradient(
                begin: Alignment(0.0 ,0.0 ),
                end: Alignment(1.0 , 1.0 ),
                colors: [homeOptions[index].colorEnd!, homeOptions[index].colorStart!]);
      case 1:
        return LinearGradient(
                begin: Alignment(0.0 ,1.0 ),
                end: Alignment(1.0 , 0.0 ),
                colors: [homeOptions[index].colorStart!, homeOptions[index].colorEnd!]);
      case 2:
        return LinearGradient(
                begin: Alignment(0.0 ,1.0 ),
                end: Alignment(1.0 , 0.0 ),
                colors: [homeOptions[index].colorEnd!, homeOptions[index].colorStart!]);
      case 3:
        return LinearGradient(
                begin: Alignment(0.0 ,0.0 ),
                end: Alignment(1.0 , 1.0 ),
                colors: [homeOptions[index].colorStart!, homeOptions[index].colorEnd!]);
      default:
        return LinearGradient(
                begin: Alignment(0.0 ,0.0 ),
                end: Alignment(1.0 , 1.0 ),
                colors: [homeOptions[index].colorStart!, homeOptions[index].colorEnd!]);
    }
  }
}
