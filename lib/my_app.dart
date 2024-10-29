import 'package:cities_of_the_world/screens/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'app/services/api_service.dart';
import 'blocs/city_bloc/city_bloc.dart';
import 'common/repository/city_repository.dart';

class MyApp extends StatelessWidget {
  final Box cityBox;

  const MyApp({Key? key, required this.cityBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiService = ApiService(dio);
    final cityRepository = CityRepository(apiService: apiService, cityBox: cityBox);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CityBloc(cityRepository),
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