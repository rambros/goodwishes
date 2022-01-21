import 'package:mobx/mobx.dart';

import '/app/modules/journeys/model/models.dart';

part 'user_step_details_controller.g.dart';

class UserStepDetailsController = _UserStepDetailsControllerBase
    with _$UserStepDetailsController;

abstract class _UserStepDetailsControllerBase with Store {

  @observable
  UserStep? _userStep;

  late List<Map<String, String>> _playlistStep;
  List<Map<String, String>> get playlistStep => _playlistStep;

  void init(UserStep userStep) {
    _userStep = userStep;
    _playlistStep = _mountPlaylist(_userStep!);
  }

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }
  
  List<Map<String, String>> _mountPlaylist(UserStep userStep) {
    return [{
      'id': '1',
      'title': 'Inspiration Audio',
      'album': 'Brahma Kumaris - GoodWishes',
      'url': userStep.step.inspirationAudioURL!,
    },
    {
      'id': '2',
      'title': 'Meditation Audio',
      'album': 'Brahma Kumaris - GoodWishes',
      'url': userStep.step.meditationAudioURL!,
    },
    ];
  }

}
