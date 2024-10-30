import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/app_bloc/app_bloc.dart';
import '../../blocs/app_bloc/app_event.dart';
import '../../blocs/app_bloc/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            final isDarkTheme = state is ThemeState ? state.isDarkTheme : false;

            return ElevatedButton(
              onPressed: () {
                context.read<AppBloc>().add(ChangeThemeEvent(!isDarkTheme));
              },
              child: Text("Toggle Theme"),
            );
          },
        ),
      ),
    );
  }
}
