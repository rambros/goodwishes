import 'package:flutter/material.dart';

import '/app/shared/services/service_locator.dart';
import '../notifiers/notifiers.dart';
import '../audio_player_controller.dart';

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          //ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: audioPlayerController.repeatButtonNotifier,
      builder: (context, value, child) {
        late Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: audioPlayerController.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<bool>(
      valueListenable: audioPlayerController.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          iconSize: 36.0,
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: (isFirst) ? null : audioPlayerController.previous,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: audioPlayerController.playButtonNotifier,
      // ignore: missing_return
      builder: (_, value, __) {
        print (value);
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              color: Colors.white,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 48.0,
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: audioPlayerController.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 48.0,
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: audioPlayerController.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<bool>(
      valueListenable: audioPlayerController.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          iconSize: 36.0,
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: (isLast) ? null : audioPlayerController.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<bool>(
      valueListenable: audioPlayerController.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: audioPlayerController.shuffle,
        );
      },
    );
  }
}
