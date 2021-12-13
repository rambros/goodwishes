import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:goodwishes/app/shared/services/authentication_service.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '/app/modules/autentica/controller/intro_controller.dart';
class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}
class _IntroPageState extends ModularState<IntroPage, IntroController> {
  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text('Journey', style: TextStyle(
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
      
      body: '''Consists of 21 steps. 21 steps of consistent practice can instill a habit. The journey will have a flow of content to build spiritual capacity and deeper experiences. Each step will have a theme/experience that is built on the previous one.  
            ''',
      image: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Image(
            image: AssetImage('assets/images/demo_meditation.png')
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
          Text('Fundamentals', style: TextStyle(
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
      '''To align & learn
Clear grounding information: the need for good wishes, what is good wishes and how you can be a good wisher
''',
      image: Center(
        child: Image(
          image: AssetImage('assets/images/demo_fundamentals.png')
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
          Text('Community', style: TextStyle(
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
          '''Community of good wishers --a space to share, engage and sustain. 
In the beginning this can be a place for sharing stories of good wishes, sharing experiences. As more members sign in to the app, we can create groups.
''',
      image: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Image(
            image: AssetImage('assets/images/demo_community.png')
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
      onDone: () => controller.afterIntroComplete(),
      onSkip: () => controller.afterIntroComplete(),
      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
      next: const Icon(Icons.navigate_next),
      done: const Text('Completed', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
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
