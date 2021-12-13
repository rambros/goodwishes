import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

import '../model/timer_music_model.dart';
import '../repository/timer_music_repository.dart';
import 'timer_service.dart';
part 'timer_music_sel_controller.g.dart';

class TimerMusicSelController = _TimerMusicSelControllerBase with _$TimerMusicSelController;

abstract class _TimerMusicSelControllerBase with Store {
  final _timerMusicRepository = Modular.get<TimerMusicRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _userService = Modular.get<UserService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  List<TimerMusic> _timerMusics = [];
  List<TimerMusic> get timerMusics => _timerMusics;

  @observable
  int _selectedItem = TimerService.selectedBackgroundMusicIndex;
  int get selectedItem => _selectedItem;

  @action
  void setSelectedMusic(index) {
    _selectedItem = index;
    TimerService.selectedBackgroundMusicIndex = index;
    TimerService.soundBackground = _timerMusics[_selectedItem];
    TimerService.selectedBackgroundMusicTitle = _timerMusics[_selectedItem].title;
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;


  bool isListeningTimerMusics = false;

  void init() {
    _timerMusics = _noMusicItemList() + getStartBackgroundMusic();
     //if (!isListeningTimerMusics) listenToTimerMusics();
  }   

  void listenToTimerMusics() {
    setBusy(true);
    isListeningTimerMusics = true;
    _timerMusicRepository.listenToTimerMusicsRealTime().listen((tmData) {
      List<TimerMusic> updatedTimerMusics = tmData;
      if (updatedTimerMusics != null && updatedTimerMusics.isNotEmpty) {
        updatedTimerMusics.forEach((element)=> element.type = 'url');
        _timerMusics = updatedTimerMusics + getStartBackgroundMusic();
        _timerMusics.sort((a, b) => a.title!.compareTo(b.title!));
        _timerMusics = _noMusicItemList() + _timerMusics;
      }
      setBusy(false);
    });
    setBusy(false);
  } 

  Future deleteTimerMusic(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer deletar esta Música?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );

    if (dialogResponse.confirmed!) {
      var tmToDelete = _timerMusics[index];
      setBusy(true);
      await _timerMusicRepository.deleteTimerMusic(_timerMusics[index].documentId);
      // Delete the image file after the post is deleted
      await _cloudStorageService.deleteImage(tmToDelete.imageFileName!);
      // Delete the audio file after the post is deleted
      await _cloudStorageService.deleteImage(tmToDelete.audioFileName!);
      setBusy(false);
    }
  }

  List<TimerMusic> _noMusicItemList() {
      return  [TimerMusic(
            title: 'Nenhuma selecionada',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 30,
            audioLocation: 'sounds/background/silencio.mp3',
            type: 'asset',
        )];
  }

  List<TimerMusic> getStartBackgroundMusic() {
    final _backgroundSounds = [
        TimerMusic(
            title: 'Cachoeira',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 15,
            audioLocation: 'sounds/background/cachoeira.mp3',
            type: 'asset',
        ),
        TimerMusic(
            title: 'Chuva',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 15,
            audioLocation: 'sounds/background/chuva.mp3',
            type: 'asset',
        ),
        TimerMusic(
            title: 'Fogueira',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 14,
            audioLocation: 'sounds/background/fogueira.mp3',
            type: 'asset',
        ),
        TimerMusic(
            title: 'Frequencia grave',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 30,
            audioLocation: 'sounds/background/grave.mp3',
            type: 'asset',
        ),
        TimerMusic(
            title: 'Ondas do mar',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 30,
            audioLocation: 'sounds/background/praia.mp3',
            type: 'asset',
        ),
        TimerMusic(
            title: 'Corrego',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 15,
            audioLocation: 'sounds/background/riacho.mp3',
            type: 'asset',
        ),
        TimerMusic(
            title: 'Vento',
            imageFileName: '',
            imageUrl: '',
            audioFileName: '',
            audioDuration: 15,
            audioLocation: 'sounds/background/vento.mp3',
            type: 'asset',
        ),
    ];
    return _backgroundSounds;
  }

}