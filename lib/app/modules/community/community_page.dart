import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/page_bar_widget.dart';
import 'community_controller.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({
    Key? key,
  }) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState
    extends ModularState<CommunityPage, CommunityController> {

  double paddingValue = 20;

  @override
  void initState() {
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
    return Scaffold(
      appBar: PageBar(title: 'Community'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          verticalSpace(32),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'A Community of Well Whishers',
                style: TextStyle(fontSize: 22, 
                              fontWeight: FontWeight.w600,
                              //color: Colors.black54,
                              ),
              ),
            ),
          ),
          verticalSpace(36),
          Text('Soon',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 48,
              color: Theme.of(context).colorScheme.primary,
            )),
          verticalSpace(36),
          Image.asset('assets/images/logo_goodwishes.png',
                      width: 220, height: 220),
        ],
      ),
    );
  }
}
