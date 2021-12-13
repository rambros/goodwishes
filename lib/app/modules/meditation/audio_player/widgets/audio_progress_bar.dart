import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '/app/shared/services/service_locator.dart';
import '../notifiers/notifiers.dart';
import '../audio_player_controller.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: audioPlayerController.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: audioPlayerController.seek,
        );
      },
    );
  }
}

