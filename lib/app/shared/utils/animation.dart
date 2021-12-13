import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';


enum AniProps { height, opacity }
class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget childWidget;

  FadeAnimation(this.delay, this.childWidget);

  ///build animation track
  @override
  Widget build(BuildContext context) {
    final _tween = TimelineTween<AniProps>()
      ..addScene(begin: 0.milliseconds, duration: 500.milliseconds)
          .animate(
            AniProps.opacity,
            tween: 0.0.tweenTo(1.0))
          .animate(
            AniProps.height,
            tween: (-30.0).tweenTo(0.1),
            curve: Curves.easeOut
          );

    return PlayAnimation<TimelineValue<AniProps>>(
        tween: _tween, // Pass in tween
        duration: _tween.duration, // Obtain duration
        delay: Duration(milliseconds: (500 * delay).round()),
        builder: (context, child, value) {
          return Opacity(
            opacity: value.get(AniProps.opacity),
            child: Transform.translate(
                offset: Offset(0, value.get(AniProps.height)), 
                child: childWidget
            ),
          );
        }
    );

    // final tween = MultiTween([
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    /// fade animation controller
    // return ControlledAnimation(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builderWithChild: (context, child, animation) => Opacity(
    //     opacity: animation["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, animation["translateY"]), child: child),
    //   ),
    // );
  }
}
