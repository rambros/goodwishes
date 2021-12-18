import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/comment/comment.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/services/dialog_service.dart';

import '/app/modules/journey/model/step_model.dart';
import '../repository/step_interface_repository.dart';

part 'step_details_controller.g.dart';

class StepDetailsController = _stepDetailsControllerBase
    with _$StepDetailsController;

abstract class _stepDetailsControllerBase with Store {
  final _stepRepository = Modular.get<IStepRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();

  @observable
  StepModel? _step;

  late List<Map<String, String>> _playlistStep;
  List<Map<String, String>> get playlistStep => _playlistStep;

  void init(StepModel Step) {
    _step = Step;
    _favoriteStep = _userService.currentUser!.favorites!.contains(_step!.documentId);
    _comments = Step.comments!.asObservable(); 
    _numLiked = _step!.numLiked;
    _numPlayed = _step!.numPlayed;
    _playlistStep = _mountPlaylist(_step!);
  }

  /// ******************* Played block ***********************
  @observable
  int? _numPlayed;

  @computed
  String get numPlayed => _numPlayed.toString();

  @action
  void addNumPlayed() {
    _step!.numPlayed = _step!.numPlayed! + 1;
    _stepRepository.updateNumPlayedStep(_step);
    _numPlayed = _numPlayed! + 1;
  }

  ///   ****************** Favorites block ********************

  @observable
  int? _numLiked;

  @observable
  bool? _favoriteStep;
  bool? get favoriteStep => _favoriteStep;

  @action
  void changeFavoriteStep() {
    _favoriteStep = !_favoriteStep!;
    _userService.changeFavorite(
        docId: _step!.documentId, addFavorite: _favoriteStep!);
    _updateNumLikedStep(_favoriteStep);
  }

  @action
  void _updateNumLikedStep(bool? favoritado) {
    if (favoritado == true) {
      _step!.numLiked = _step!.numLiked! + 1;
    } else {
      _step!.numLiked = _step!.numLiked! - 1;
    }
    _numLiked = _step!.numLiked;
    _stepRepository.updateNumLikedStep(_step);
  }

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

  bool canDeleteComment(Comment comment) {
    if ((_userService.currentUser!.uid == comment.userId) ||
        (_userService.userRole == 'Admin')) {
      return true;
    } else {
      return false;
    }
  }

  @action
  Future deleteComment(Comment comment) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza?',
      description: 'Você realmente quer deletar este comentário?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );

    if (dialogResponse.confirmed!) {
      setBusy(true);
      //delete from list
      _comments!.removeWhere(((item) => comment.hashCode == item.hashCode));

      //update Step
      _step!.comments = _comments;
      var result;
      result = await _stepRepository.deleteStepComments(
          _step, comment);

      if (result is String) {
        await _dialogService.showDialog(
          title: 'Não foi possivel deletar o comentário',
          description: result,
        );
      }
      // else {
      // await _dialogService.showDialog(
      //   title: 'Comentário deletado',
      //   description: 'O comentário foi deletado',
      // );
      // }
      setBusy(false);
    }
  }

  @action
  Future addComment(String commentText) async {
    // pegar dados do usuario
    var userApp = _userService.currentUser!;
    final userImageUrl = userApp.userImageUrl;
    final userId = userApp.uid;
    final userName = userApp.fullName;

    // montar DAO Comment
    var userComment = Comment(
      userId: userId,
      userImageUrl: userImageUrl,
      userName: userName,
      comment: commentText == null ? '' : commentText,
      commentDate: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
    );
    _comments!.add(
        userComment); // para o observer (pointer para _step.comments)
    //_step.comments.add(userComment); //para salvar

    // salvar no repositorio Step (ver step_edit_controller)
    var result;
    result = await _stepRepository.updateStepComments(
        _step, _comments);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar o comentário',
        description: result,
      );
    }
    return numComments;
  }

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  
  List<Map<String, String>> _mountPlaylist(StepModel step) {
    return [{
      'id': '1',
      'title': 'Inspiration Audio',
      'album': 'Brahma Kumaris - GoodWishes',
      'url': step.inspirationAudioURL!,
    },
    {
      'id': '2',
      'title': 'Meditation Audio',
      'album': 'Brahma Kumaris - GoodWishes',
      'url': step.meditationAudioURL!,
    },
    ];
  }

}
