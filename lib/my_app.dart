import 'package:cities_of_the_world/screens/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'app/services/api_service.dart';
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
        BlocProvider(
          create: (context) => CityBloc(cityRepository)..add(LoadCitiesEvent()), // Dispatch event here
        ),
      ],
      child: MaterialApp(
        title: 'Cities of the World',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
