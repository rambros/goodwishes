import 'package:flutter/material.dart';

import '/app/shared/services/service_locator.dart';
import '../audio_player_controller.dart';

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: audioPlayerController.add,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: audioPlayerController.remove,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}