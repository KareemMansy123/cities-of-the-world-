import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/app_bloc/app_bloc.dart';
import '../../blocs/app_bloc/app_event.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Dark Theme'),
          value: context.watch<AppBloc>().isDarkTheme,
          onChanged: (value) {
            context.read<AppBloc>().add(ChangeThemeEvent(value));
          },
        ),
      ),
    );
  }
}
