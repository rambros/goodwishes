import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String? error;
  ServerFailure({this.error});
}

//class CacheFailure extends Failure {}