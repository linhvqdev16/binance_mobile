import 'package:equatable/equatable.dart';

abstract class ErrorHandle extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends ErrorHandle {}

class ConnectionFailure extends ErrorHandle {}
