import 'package:flutter/material.dart';

import '/app/shared/services/service_locator.dart';
import '../audio_player_controller.dart';

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<String>(
      valueListenable: audioPlayerController.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(fontSize: 40)),
        );
      },
    );
  }
}