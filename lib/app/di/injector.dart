import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import '../../blocs/app_bloc/app_bloc.dart';
import '../../blocs/city_bloc/city_bloc.dart';
import '../../common/models/city.dart';
import '../../common/repository/city_repository.dart';
import '../../common/repository/city_repository_impl.dart';
import '../../common/user_case/city.dart';
import '../../common/user_case/search.dart';
import '../services/api_service.dart';
final getIt = GetIt.instance;

Future<void> setupInjection() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(CityAdapter());
  final cityBox = await Hive.openBox<City>('cityBox');

  getIt.registerSingleton<Box<City>>(cityBox);
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<CityRepository>(CityRepositoryImpl(cityBox: cityBox));

  getIt.registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>());

  // Register Use Cases
  getIt.registerSingleton<FetchCitiesUseCase>(FetchCitiesUseCase(getIt<CityRepository>()));
  getIt.registerSingleton<SearchCitiesUseCase>(SearchCitiesUseCase(getIt<CityRepository>()));

  // Register BLoCs
  getIt.registerFactory<AppBloc>(() => AppBloc());
  getIt.registerFactory<CityBloc>(() => CityBloc(
    fetchCitiesUseCase: getIt<FetchCitiesUseCase>(),
    searchCitiesUseCase: getIt<SearchCitiesUseCase>(),
  ));
}

