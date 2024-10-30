import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  bool isDarkTheme = false;

  AppBloc() : super(AppLoadingState()) {
    on<AppStarted>((event, emit) async {
      emit(AppLoadedState());
    });

    on<ChangeThemeEvent>((event, emit) async {
      isDarkTheme = event.isDarkTheme;
      emit(ThemeState(isDarkTheme));
    });
  }
}
