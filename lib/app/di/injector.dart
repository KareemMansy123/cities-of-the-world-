import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import '../../blocs/app_bloc/app_bloc.dart';
import '../../blocs/city_bloc/city_bloc.dart';
import '../../common/models/city.dart';
import '../../common/repository/city_repository.dart';
import '../services/api_service.dart';
final getIt = GetIt.instance;

Future<void> setupInjection() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  // Register Hive adapters
  Hive.registerAdapter(CityAdapter());

  // Open the Hive box
  final cityBox = await Hive.openBox<City>('cityBox');

  // Register Hive box
  getIt.registerSingleton<Box<City>>(cityBox);

  // Register services and repositories
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<CityRepository>(
    CityRepository(
      apiService: getIt<ApiService>(),
      cityBox: getIt<Box<City>>(),
    ),
  );

  // Register BLoCs
  getIt.registerFactory<AppBloc>(() => AppBloc());
  getIt.registerFactory<CityBloc>(() => CityBloc(getIt<CityRepository>()));
}