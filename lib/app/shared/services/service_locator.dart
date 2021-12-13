import 'package:get_it/get_it.dart';
import 'package:audio_service/audio_service.dart';

import '/app/modules/meditation/audio_player/audio_player_service.dart';
import '/app/modules/meditation/audio_player/audio_player_controller.dart';
import '/app/modules/meditation/audio_player/playlist_repository.dart';


GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page controller state
  getIt.registerLazySingleton<AudioPlayerController>(() => AudioPlayerController());

}