import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/author/controller/author_controller.dart';
import '/app/shared/comment/comment.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/services/dialog_service.dart';

import '../model/meditation.dart';
import '../repository/med_interface_repository.dart';

part 'med_details_controller.g.dart';

class MeditationDetailsController = _MeditationDetailsControllerBase
    with _$MeditationDetailsController;

abstract class _MeditationDetailsControllerBase with Store {
  final _meditationRepository = Modular.get<IMeditationRepository>();
  final _dialogService = Modular.get<DialogService>();
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

  @action
  void addNumPlayed() {
    _meditation!.numPlayed = _meditation!.numPlayed! + 1;
    _meditationRepository.updateNumPlayedMeditation(_meditation);
    _numPlayed = _numPlayed! + 1;
  }

  ///   ****************** Favorites block ********************

  @observable
  int? _numLiked;

  @observable
  bool? _favoriteMeditation;
  bool? get favoriteMeditation => _favoriteMeditation;

  @action
  void changeFavoriteMeditation() {
    _favoriteMeditation = !_favoriteMeditation!;
    _userService.changeFavorite(
        docId: _meditation!.documentId, addFavorite: _favoriteMeditation!);
    _updateNumLikedMeditation(_favoriteMeditation);
  }

  @action
  void _updateNumLikedMeditation(bool? favoritado) {
    if (favoritado == true) {
      _meditation!.numLiked = _meditation!.numLiked! + 1;
    } else {
      _meditation!.numLiked = _meditation!.numLiked! - 1;
    }
    _numLiked = _meditation!.numLiked;
    _meditationRepository.updateNumLikedMeditation(_meditation);
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

      //update meditation
      _meditation!.comments = _comments;
      var result;
      result = await _meditationRepository.deleteMeditationComments(
          _meditation, comment);

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
        userComment); // para o observer (pointer para _meditation.comments)
    //_meditation.comments.add(userComment); //para salvar

    // salvar no repositorio Meditation (ver meditation_edit_controller)
    var result;
    result = await _meditationRepository.updateMeditationComments(
        _meditation, _comments);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar o comentário',
        description: result,
      );
    }
    // else {
    //   await _dialogService.showDialog(
    //     title: 'Comentário atualizado com sucesso',
    //     description: 'Seu comentário foi incluído',
    //   );
    // }
    return numComments;
  }

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
