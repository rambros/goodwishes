import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '/app/modules/journey/statistics/model/meditation_log.dart';
import '/app/modules/journey/statistics/repository/med_statistics_repository.dart';
import '/app/shared/services/analytics_service.dart';
import '/app/shared/services/service_locator.dart';
import 'notifiers/notifiers.dart';
import 'player_model.dart';
import 'playlist_repository.dart';

class AudioPlayerController {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final AudioHandler? _audioHandler = getIt<AudioHandler>();

  Stopwatch watch = Stopwatch();

  // Events: Calls coming from the UI
  void init(PlayerModel _model) async {
    print('init do controller do audio');
    //await _loadPlaylist();
    await _loadMusic(_model);
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  Future<void> _loadPlaylist() async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = await songRepository.fetchInitialPlaylist();
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              extras: {'url': song['url']},
            ))
        .toList();
    await _audioHandler!.addQueueItems(mediaItems);
  }

   Future<void> _loadMusic(PlayerModel _model) async {
    final mediaItem = MediaItem(
              id: 'Meditação',
              album: 'MeditaBk Songs',
              title: _model.title ?? '',
              extras: {'url': _model.urlAudio},
            );
    await _audioHandler!.addQueueItem(mediaItem);
  }

  void _listenToChangesInPlaylist() {
    _audioHandler!.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
        final newList = playlist.map((item) => item.title).toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler!.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler!.seek(Duration.zero);
        _audioHandler!.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler!.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler!.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler!.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler!.mediaItem.value;
    final playlist = _audioHandler!.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() {
    _audioHandler!.play();
    watch.start();
  }

  void pause() {
    _audioHandler!.pause();
    watch.stop();
  } 

  void seek(Duration position) => _audioHandler!.seek(position);

  void previous() => _audioHandler!.skipToPrevious();
  void next() => _audioHandler!.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler!.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler!.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler!.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler!.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler!.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  Future<void> add() async {
    final songRepository = getIt<PlaylistRepository>();
    final song = await songRepository.fetchAnotherSong();
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      album: song['album'] ?? '',
      title: song['title'] ?? '',
      extras: {'url': song['url']},
    );
    await _audioHandler!.addQueueItem(mediaItem);
  }

  void remove() {
    final lastIndex = _audioHandler!.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler!.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler!.customAction('dispose');
    //_audioHandler.stop();
  }

  void stop() {
    _audioHandler!.stop();
  }

  void saveStatistics(PlayerModel _model) async {
    var duration = watch.elapsed.inSeconds;
    final df = DateFormat('yyyy-MM-dd');
    final tf = DateFormat('hh:mm');
    final dateMeditation = df.format(DateTime.now());
    final timeMeditation = tf.format(DateTime.now());

    final log = MeditationLog(
      duration: duration,
      date: DateTime.now(),
      type: 'guided',
    );
    
    // gravar log da meditation
    final _meditationStatisticsReposytory = Modular.get<MeditationStatisticsRepository>();
    _meditationStatisticsReposytory.saveMeditationStatistic(log);

    //gravar analytics de meditation
    final _analyticsService = Modular.get<AnalyticsService>();
    await _analyticsService.logMeditation(
        title:  _model.title,
        meditationId: _model.id,
        duration: duration,
        date: dateMeditation,
        time: timeMeditation,
        type: 'conduzida', 
    );
    watch.stop();
  }
}
