import 'package:cities_of_the_world/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'blocs/app_bloc/app_bloc.dart';
import 'blocs/app_bloc/app_state.dart';
import 'blocs/city_bloc/city_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (_) => GetIt.instance<AppBloc>()),
        BlocProvider<CityBloc>(create: (_) => GetIt.instance<CityBloc>()),
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
            navigatorKey: GetIt.I<GlobalKey<NavigatorState>>(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}