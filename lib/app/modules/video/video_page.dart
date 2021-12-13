import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/page_bar_widget.dart';

import 'video_controller.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    Key? key,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends ModularState<VideoPage, VideoController> {

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
      appBar: PageBar(title: 'Vídeos'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //verticalSpace(MediaQuery.of(context).size.height * .08,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(),
          //   child: Text(
          //     'MeditaBK',
          //     style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          //   ),
          // ),
          // RichText(
          //   text: TextSpan(
          //     text: 'Bem-vindo ao ',
          //     style: TextStyle(
          //         fontFamily: 'Poppins',
          //         fontSize: 20,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.grey[700]),
          //     children: <TextSpan>[
          //       TextSpan(
          //           text: 'MeditaBK',
          //           style: TextStyle(
          //               color: Colors.black, fontWeight: FontWeight.w600)),
          //       // TextSpan(
          //       //     text: 'BK',
          //       //     style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w600)),
          //     ],
          //   ),
          // ),
          verticalSpace(32),
          Center(
            child: Text(
              'Aulas e palestras em vídeo',
              style: TextStyle(fontSize: 22, 
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
                          color: homeOptions[index].colorStart,
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
}


