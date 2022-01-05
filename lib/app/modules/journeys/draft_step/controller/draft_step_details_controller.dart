import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/modules/journeys/model/step_model.dart';
import '/app/shared/comment/comment.dart';
import '/app/shared/services/user_service.dart';

part 'draft_step_details_controller.g.dart';

class DraftStepDetailsController = _DraftStepDetailsControllerBase
    with _$DraftStepDetailsController;

abstract class _DraftStepDetailsControllerBase with Store {
  final _userService = Modular.get<UserService>();

  @observable
  StepModel? _step;

  void init(StepModel step) {
    _step = step;
    _favoriteMeditation =
        _userService.currentUser!.favorites!.contains(_step!.documentId);
    _comments = step.comments!.asObservable(); //meditation pointer
    _numLiked = _step!.numLiked;
    _numPlayed = _step!.numPlayed;
  }

  /// ******************* Played block ***********************
  @observable
  int? _numPlayed;

  @computed
  String get numPlayed => _numPlayed.toString();

  // @action
  // void addNumPlayed() {
  //   _step.numPlayed++;
  //   _DraftStepRepository.updateNumPlayedMeditation(_step);
  //   _numPlayed++;
  // }

  ///   ****************** Favorites block ********************

  @observable
  int? _numLiked;

  @observable
  bool? _favoriteMeditation;
  bool? get favoriteMeditation => _favoriteMeditation;

  // @action
  // void changeFavoriteMeditation() {
  //   _favoriteMeditation = !_favoriteMeditation;
  //   _userService.changeFavorite(
  //       docId: _step.documentId, addFavorite: _favoriteMeditation);
  //   _updateNumLikedMeditation(_favoriteMeditation);
  // }

  // @action
  // void _updateNumLikedMeditation(bool favoritado) {
  //   if (favoritado == true) {
  //     _step.numLiked++;
  //   } else {
  //     _step.numLiked--;
  //   }
  //   _numLiked = _step.numLiked;
  //   _DraftStepRepository.updateNumLikedMeditation(_step);
  // }

  @computed
  String get numLiked => _numLiked.toString();

  /// ***************** Coments block *************************
  ObservableList<Comment>? _comments;

  //@computed
  ObservableList<Comment>? get orderComments {
    _comments!.sort((a, b) => b.commentDate!.compareTo(a.commentDate!));
    return _comments;
  }

  @computed
  ObservableList<Comment>? get comments => _comments;

  @computed
  int get numComments => _comments!.length;


  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

}
