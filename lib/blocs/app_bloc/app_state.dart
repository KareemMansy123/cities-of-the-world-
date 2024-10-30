// app_state.dart
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppLoadingState extends AppState {}

class AppLoadedState extends AppState {}

class ThemeState extends AppState {
  final bool isDarkTheme;

  const ThemeState(this.isDarkTheme);

  @override
  List<Object?> get props => [isDarkTheme];
}
