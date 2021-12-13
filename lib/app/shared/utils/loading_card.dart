import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/app_controller.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'color.dart';


class LoadingFeaturedCard extends StatelessWidget {
  const LoadingFeaturedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appSettings = Modular.get<AppController>();
    return SkeletonAnimation(
        child: Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: _appSettings.isDarkTheme == false ? loadingColorLight : loadingColorDark,
                borderRadius: BorderRadius.circular(5))));
  }
}

class LoadingCard extends StatelessWidget {
  final double height;
  const LoadingCard({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appSettings = Modular.get<AppController>();
    return Container(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: _appSettings.isDarkTheme == false ? loadingColorLight : loadingColorDark, 
              borderRadius: BorderRadius.circular(5)),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
