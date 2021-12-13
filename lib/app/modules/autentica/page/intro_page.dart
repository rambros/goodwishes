import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '/app/shared/services/authentication_service.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final sb = Modular.get<AuthenticationService>();
  void afterIntroComplete (){
    sb.setSignIn();
    Modular.to.pushReplacementNamed('/');
    //nextScreenReplace(context, HomePage());
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text('Meditações', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black87,
          ),),
          SizedBox(height: 8,),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
      
      body: '''O MeditaBK é o seu amigo que lhe ajuda a meditar. \nCom meditações guiadas em áudio e vídeo fica mais fácil parar por alguns minutos, respirar e ter uma vida mais serena e positiva. \nVocê pode ativar lembretes diários para praticar e acompanhar seu progresso no quadro de estatísticas. 
            ''',
      image: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Image(
            image: AssetImage('assets/images/star_small.png')
          )
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(color: Colors.black87, 
                            fontSize: 16,),
        descriptionPadding: EdgeInsets.only(left: 30, right: 30),
        imagePadding: EdgeInsets.fromLTRB(8, 30, 8 , 0)
      ),
    ),

    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text('Agenda e Programação', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black87,
          ),),
          SizedBox(height: 8,),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
      
      body:
      '''Acesse todas as atividades online do site da Brahma Kumaris como palestras, cursos e workshops. \n\nEscolha entre os diversos temas sobre melhoria de qualidade de vida, meditação e autoconhecimento. \n\nPara facilitar, faça sua inscrição por meio do app.''',
      image: Center(
        child: Image(
          image: AssetImage('assets/images/star_agenda_small.png')
        ),
      ),


      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(color: Colors.black87, fontSize: 16),
        descriptionPadding: EdgeInsets.only(left: 30, right: 30),
        imagePadding: EdgeInsets.fromLTRB(8, 30, 8 , 0)
      ),
    ),

    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text('Reflexões', style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),),
          SizedBox(height: 8,),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
      
      body:
          '''No Medita BK, você acessa mensagens diárias que são fonte de inspiração para ter atitudes e pensamentos mais positivos.
\nVocê tem na palma da sua mão diversos vídeos de reflexões, palestras e entrevistas para o autoconhecimento.''',
      image: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Image(
            image: AssetImage('assets/images/star_escutando_small.png')
          ),
        )
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(color: Colors.black87, fontSize: 16),
        descriptionPadding: EdgeInsets.only(left: 30, right: 30),
        imagePadding: EdgeInsets.fromLTRB(8, 30, 8 , 0)
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () {
        afterIntroComplete();
      },
      onSkip: () {
        afterIntroComplete();
      },
      showSkipButton: true,
      skip: const Text('Pular', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
      next: const Icon(Icons.navigate_next),
      done: const Text('Concluído', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(7.0),
          activeSize: const Size(20.0, 5.0),
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0))),
    );
  }
}
