import 'package:cities_of_the_world/screens/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'app/services/api_service.dart';
import 'blocs/app_bloc/app_bloc.dart';
import 'blocs/app_bloc/app_event.dart';
import 'blocs/app_bloc/app_state.dart';
import 'blocs/city_bloc/city_bloc.dart';
import 'blocs/city_bloc/city_event.dart';
import 'common/repository/city_repository.dart';

class MyApp extends StatelessWidget {
  final CityRepository cityRepository;

  const MyApp({Key? key, required this.cityRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (_) => AppBloc()..add(AppStarted())),
        BlocProvider<CityBloc>(create: (_) => CityBloc(cityRepository)),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          bool isDarkTheme = false;
          if (state is ThemeState) {
            isDarkTheme = state.isDarkTheme;
          }
          return MaterialApp(
            title: 'Cities of the World',
            theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}