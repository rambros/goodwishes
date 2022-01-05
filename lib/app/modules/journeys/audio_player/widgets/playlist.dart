import 'package:flutter/material.dart';

import '/app/shared/services/service_locator.dart';
import '../audio_player_controller.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: audioPlayerController.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${playlistTitles[index]}',
                  style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w400),
                  ),
              );
            },
          );
        },
      ),
    );
  }
}