import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/splash/splash-model.dart';
import '/app/shared/utils/color.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController? _pagecontroller;
  int currentPage = 0;

  final List<SplashModel> welcomePages = [
    SplashModel(
        header: 'Reflexões',
        title: 'Reflexões',
        description:
            'Reflexões sobre a prática da espiritualidade no dia-a-dia, as quais trazem  autorrespeito e autotransformacão.',
        img: 'assets/images/ref-welcome.png'),
    SplashModel(
        header: 'Meditações',
        title: 'Meditações',
        description:
            'Meditações para você experimentar sua verdadeira natureza de paz e para progredir na sua jornada de desenvolvimento pessoal.',
        img: 'assets/images/star01.png'),
    SplashModel(
        header: 'Sugestões',
        title: 'Sugestões',
        description:
            'Convites para palestras, workshops, cursos. Publicacões afins . Dicas sobre  livros,etc.',   
        img: 'assets/images/post-welcome.png'),
  ];

  @override
  void initState() {
    _pagecontroller = PageController();
    _pagecontroller!.addListener(() {
      if (currentPage != _pagecontroller!.page!.floor() &&
          (_pagecontroller!.page == 0.0 ||
              _pagecontroller!.page == 1.0 ||
              _pagecontroller!.page == 2.0)) {
        setState(() {
          currentPage = _pagecontroller!.page!.floor();
        });
      }
    });
    super.initState();
  }

    @override
  void dispose() {
    _pagecontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: PageView.builder(
                        controller: _pagecontroller,
                        itemCount: 3,
                        itemBuilder: (context, position) {
                          var data = welcomePages[position];
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(data.img!))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(height: 10),
                                        // Text(
                                        //   data.header,
                                        //   style: TextStyle(
                                        //       color: textColor,
                                        //       fontSize: 40,
                                        //       fontWeight: FontWeight.w500),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 37),
                                    margin: const EdgeInsets.only(bottom: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(data.title!,
                                            style: TextStyle(
                                                fontSize: 28,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: 15.0),
                                        Text(data.description!,
                                            style: TextStyle(fontSize: 18, color: Colors.white,))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                buildBottomNavigationBar()
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            left: MediaQuery.of(context).size.width / 2.4,
            child: buildPageIndicator(),
          )
        ],
      ),
    );
  }

  Container buildPageIndicator() {
    var indicatorsize = 16.0;
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: indicatorsize,
            height: indicatorsize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indicatorsize),
                color: currentPage == 0 ?  Theme.of(context).toggleableActiveColor: Colors.white,
                border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2.0)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: indicatorsize,
            height: indicatorsize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indicatorsize),
                color: currentPage == 1 ? Theme.of(context).toggleableActiveColor : Colors.white,
                border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2.0)),
          ),
          Container(
            width: indicatorsize,
            height: indicatorsize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indicatorsize),
                color: currentPage == 2 ? Theme.of(context).toggleableActiveColor : Colors.white,
                border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2.0)),
          )
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return InkWell(
      onTap: () {
        Modular.to.pushReplacementNamed('/login');
      },
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 40.0),
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints.expand(),
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  'Iniciar',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              color: Theme.of(context).colorScheme.secondary,
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
            )
          ],
        ),
      ),
    );
  }


}
