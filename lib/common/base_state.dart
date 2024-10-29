import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object> get props => [];
}

class LoadingState extends BaseState {}

class SuccessState<T> extends BaseState {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object> get props => [data as Object];
}

class FailureState extends BaseState {
  final String error;

  const FailureState(this.error);

  @override
  List<Object> get props => [error];
}
