import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AppEvent {}

class ChangeThemeEvent extends AppEvent {
  final bool isDarkTheme;

  const ChangeThemeEvent(this.isDarkTheme);

  @override
  List<Object?> get props => [isDarkTheme];
}
