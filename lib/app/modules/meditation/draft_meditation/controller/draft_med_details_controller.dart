import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/author/controller/author_controller.dart';
import '/app/shared/comment/comment.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/modules/meditation/guided/model/meditation.dart';

part 'draft_med_details_controller.g.dart';

class DraftMeditationDetailsController = _DraftMeditationDetailsControllerBase
    with _$DraftMeditationDetailsController;

abstract class _DraftMeditationDetailsControllerBase with Store {
  final _userService = Modular.get<UserService>();
  final _authorController = Modular.get<AuthorController>();

  @observable
  Meditation? _meditation;

  void init(Meditation meditation) {
    _meditation = meditation;
    _favoriteMeditation =
        _userService.currentUser!.favorites!.contains(_meditation!.documentId);
    _comments = meditation.comments!.asObservable(); //meditation pointer
    _numLiked = _meditation!.numLiked;
    _numPlayed = _meditation!.numPlayed;
    getAuthorMeditation(_meditation!.authorId);
  }

  /// ******************* Played block ***********************
  @observable
  int? _numPlayed;

  @computed
  String get numPlayed => _numPlayed.toString();

  // @action
  // void addNumPlayed() {
  //   _meditation.numPlayed++;
  //   _draftMeditationRepository.updateNumPlayedMeditation(_meditation);
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
  //       docId: _meditation.documentId, addFavorite: _favoriteMeditation);
  //   _updateNumLikedMeditation(_favoriteMeditation);
  // }

  // @action
  // void _updateNumLikedMeditation(bool favoritado) {
  //   if (favoritado == true) {
  //     _meditation.numLiked++;
  //   } else {
  //     _meditation.numLiked--;
  //   }
  //   _numLiked = _meditation.numLiked;
  //   _draftMeditationRepository.updateNumLikedMeditation(_meditation);
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

/// ********************** Author Meditation ****************************
  UserApp? author;
  
  Future<UserApp?> getAuthorMeditation(String? authorId) async {
      author = await _authorController.getAuthorById(authorId);
      return author;
  }

}
